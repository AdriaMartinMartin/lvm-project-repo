/*
Type: benchmark
Size: ~150 LOC

A benchmark application that renders a 3D scene using a ray tracer. This
heavy math computation measures the VM's performance on a mix of object
manipulation for vector math, deeply nested loops, and a high volume of
integer arithmetic using scaled integers.

I want to give credit to this git post from which I modified and transformed the code into this benchmark: https://gist.github.com/rossant/6046463
*/


function vec(x, y, z) {
  v = new();
  v.x = x; v.y = y; v.z = z;
  return v;
}

function vec_add(v1, v2) {
  return vec(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z);
}

function vec_sub(v1, v2) {
  return vec(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z);
}


function vec_scale(v, s) {
  return vec(v.x * s / 100, v.y * s / 100, v.z * s / 100);
}

function vec_dot(v1, v2) {
  return (v1.x * v2.x + v1.y * v2.y + v1.z * v2.z) / 100;
}

function vec_sq_mag(v) {
  return vec_dot(v, v);
}

// An integer square root function using binary search.
// Required for solving the ray-sphere intersection equation.
function isqrt(n) {
  if (n < 0) { return 0; }
  low = 1;
  high = n;
  root = 1;
  while (low <= high) {
    mid = (low + high) / 2;
    if (mid == 0) { return 0; } // Avoid division by zero
    if (mid <= n / mid) {
      root = mid;
      low = mid + 1;
    } else {
      high = mid - 1;
    }
  }
  return root;
}

// Solves for the nearest intersection of a ray with a sphere.
// Returns the distance 't' if an intersection is found, or a large number if not.
function intersect_sphere(ray_origin, ray_dir, sphere) {
  oc = vec_sub(ray_origin, sphere.center);
  a = vec_dot(ray_dir, ray_dir);
  b = 2 * vec_dot(oc, ray_dir);
  c = vec_dot(oc, oc) - (sphere.radius * sphere.radius / 1000);

  discriminant = b * b - 4 * a * c;
  if (discriminant < 0) {
    return 999999; // No intersection
  }

  // Find the nearest intersection point (smallest positive t).
  t = ((-b - isqrt(discriminant)) * 1000) / (2 * a);
  if (t > 0) {
    return t;
  }

  // Try the other root if the first is behind the ray.
  t2 = ((-b + isqrt(discriminant)) * 1000) / (2 * a);
  if (t2 > 0) {
    return t2;
  }

  return 999999;
}


function benchmark() {
  width = 32;
  height = 32;

  scene = new();
  scene[0] = new();
  scene[0].center = vec(0, -100, -300); // Was -1000, -3000
  scene[0].radius = 100;                // Was 1000
  scene[0].color = 500;

  scene[1] = new();
  scene[1].center = vec(0, 0, -300);    // Was -3000
  scene[1].radius = 50;                 // Was 500
  scene[1].color = 900;

  light_dir = vec(577, 577, -577);
  camera_origin = vec(0, 0, 100);       // Was 1000

  checksum = 0;

  y = 0;
  while (y < height) {
    x = 0;
    while (x < width) {
      px = x - width / 2;
      py = y - height / 2;
      ray_dir = vec(px, py, -100); // Was -1000

      min_t = 999999;
      hit_obj = -1;
      i = 0;
      while (i < getSize(scene)) {
        t = intersect_sphere(camera_origin, ray_dir, scene[i]);
        if (t < min_t) {
          min_t = t;
          hit_obj = i;
        }
        i = i + 1;
      }

      if (hit_obj > -1) {
        hit_point = vec_add(camera_origin, vec_scale(ray_dir, min_t));
        normal = vec_sub(hit_point, scene[hit_obj].center);
        brightness = vec_dot(normal, light_dir);
        if (brightness < 0) {
          brightness = 0;
        }
        checksum = checksum + (brightness * scene[hit_obj].color / 1000);
      }
      x = x + 1;
    }
    y = y + 1;
  }

  // --- Correctness Check ---
  if (checksum != 5615063) {
    println("Benchmark failed! Incorrect checksum.");
  }
}


function main() {
  ITERATIONS = 20;
  MEASURE_FROM = 16;
  NAME = "Simple Ray Tracer";

  time = 0;
  it = 0;
  while (it < ITERATIONS) {
    s = nanoTime();
    benchmark();
    e = nanoTime() - s;
    if (it >= MEASURE_FROM) {
      time = time + e;
    }
    it = it + 1;
  }

  avg = time / (ITERATIONS - MEASURE_FROM);
  println(NAME + ": " + avg);
}
