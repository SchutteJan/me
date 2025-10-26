---
date: 2025-10-25
title: Receipt Demo
---


Receipts have a particular style. And since I use a monospace font on this website I can recreate one using box drawing characters.

<figure>
``` {#receipt-example}
╔══════════════════════════════╗
║      CORNER COFFEE SHOP      ║
║      123 Main Street         ║
║    Portland, OR 97201        ║
╠══════════════════════════════╣
║                              ║
║  Date: 2025-10-25            ║
║  Time: 09:42 AM              ║
║  Cashier: Alice              ║
║                              ║
║                              ║
║                              ║
║                              ║
║                              ║
║                              ║
║                              ║
║                              ║
║                              ║
║                              ║
╠══════════════════════════════╣
║                              ║
║  Cappuccino (L)      $4.50   ║
║  Croissant           $3.25   ║
║  Blueberry Muffin    $3.75   ║
║                              ║
║ ─────────────────────────────╢
║  Subtotal:          $11.50   ║
║  Tax (8%):           $0.92   ║
╠══════════════════════════════╣
║  TOTAL:             $12.42   ║
╠══════════════════════════════╣
║                              ║
║  Payment: Credit Card        ║
║  Card: ****1234              ║
║  Auth Code: 789456           ║
║                              ║
╠══════════════════════════════╣
║   Thank you for visiting!    ║
║     Please come again!       ║
║                              ║
║  Receipt #: 2025-4821        ║
╚══════════════════════════════╝
```
<figcaption>
    Example receipt
</figcaption>
</figure>

<figure>
``` {#receipt-arcade}
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   PIXEL ARCADE & BAR         ┃
┃   456 Retro Lane             ┃
┃   Tokyo, JP 150-0001         ┃
┃                              ┃
┃   Server: Yuki  Table: 12    ┃
┃   2025-10-25    22:15        ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃                              ┃
┃   2x Draft Beer       ¥1,600 ┃
┃   1x Edamame            ¥500 ┃
┃   1x Karaage Chicken    ¥800 ┃
┃   1x Gyoza (6pc)        ¥700 ┃
┃   3x Arcade Tokens      ¥900 ┃
┃                              ┃
┃   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈  ┃
┃   Subtotal:           ¥4,500 ┃
┃   Service (10%):        ¥450 ┃
┃   ━━━━━━━━━━━━━━━━━━━━━━━━━  ┃
┃   TOTAL:              ¥4,950 ┃
┃   ━━━━━━━━━━━━━━━━━━━━━━━━━  ┃
┃                              ┃
┃   Cash Paid:          ¥5,000 ┃
┃   Change:                ¥50 ┃
┃                              ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
┃  ★ High Score:  125,400 ★    ┃
┃  Player: YUKI - Game: PAC    ┃
┃                              ┃
┃  Order #: A-1042             ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```
<figcaption>
    Alternative style with heavy lines
</figcaption>
</figure>


<script>
/* Animate printing a receipt */
function startPrintAnimation(preElementId) {
  const preElement = document.getElementById(preElementId);
  const codeElement = preElement.querySelector("code");

  // Store original content and measure height
  const fullReceipt = codeElement.textContent;
  const lines = fullReceipt.split("\n");
  const originalHeight = preElement.offsetHeight;

  // Set fixed height to prevent layout shift
  preElement.style.height = originalHeight + "px";
  preElement.style.overflow = "hidden";

  setTimeout(function () {
    // Clear content
    codeElement.textContent = "";

    // Animation variables - start from the last line
    let currentLine = lines.length - 1;

    function printNextLine() {
      if (currentLine < 0) {
        return;
      }

      // Prepend line (add to the beginning)
      const currentLineText = lines[currentLine];
      codeElement.textContent =
        currentLineText +
        (currentLine < lines.length - 1 ? "\n" : "") +
        codeElement.textContent;

      currentLine--;

      // Variable speed based on content density - more content = slower
      // Count non-space, non-border characters (actual content)
      const contentChars = currentLineText.replace(/[║│┃ ═━─┈]/g, "").length;
      const baseDelay = 30;
      const contentDelay = contentChars * 5;
      setTimeout(printNextLine, baseDelay + contentDelay);
    }

    printNextLine();
  }, 50);
}
// Check for reduced motion preference
const prefersReducedMotion = window.matchMedia(
  "(prefers-reduced-motion: reduce)",
).matches;

if (!prefersReducedMotion) {
  startPrintAnimation("receipt-example");
  setTimeout(() => {
    startPrintAnimation("receipt-arcade");
  }, 100)
}
</script>
