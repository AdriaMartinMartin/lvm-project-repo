// CATEGORY: strings

function main() {
  emoji1 = "🚀";
  emoji2 = "⭐";
  if (getSize("🚀") != 2) {
    println("ERROR: emoji size wrong");
  }
  
  text = "Hello";
  
  combined = emoji1 + " " + text + " " + emoji2;
  println(combined);
  
  unicode = "café";
  println(unicode + " ☕");
  
  if (emoji1 + emoji2 != "🚀⭐") {
    println("ERROR: emoji concat failed");
  }
  mixed = "Test " + emoji1 + emoji2 + " end";
  println(mixed);
  
  symbols = "α β γ δ";
  println(symbols);
}
