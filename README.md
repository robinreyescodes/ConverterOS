# ConverterOS
## The what
A currency converter app that utilizes the freecurrencyapi to convert any whole number cash amount to its' converted value from a number of selectable options. Currencies are live currency values from around the world and dynamically changes depending on its' real life currency rate. 

## The why
In the beginning of April, my parents went on a trip to the Philippines to look at a piece of land they were thinking of buying. I asked them how much it was and they gave me an answer in pesos. I didn't know what the conversion was to dollars. I had to go to google it and it took some time to get the answer. I thought, why not make an app that makes it fast and easy for me to find that conversion...and here we are. 

## The how to get started
**Make sure to convert WHOLE NUMBER values. Bug in the app...more explanation below**  
1) Start my cloning the repo onto a local directory
2) Double click the CurrencyProject.xcodeproj file to open project in xcode
3) Run the build with simulator
4) Start playing with the app!

Super simple to use - select your current currency and the currency you want to convert to, then press the convert button. See the converted amount along with its symbol appear! 

Currently, the included currencies in the app are...
  - USD 🇺🇸
  - EUR 🇪🇺
  - GBP 🇬🇧
  - CAD 🇨🇦
  - MXN 🇲🇽
  - PHP 🇵🇭
  - KRW 🇰🇷
  - AUD 🇦🇺
  - JPY 🇯🇵
  - CNY 🇨🇳
  - TRY 🇹🇷

Enjoy! 

## Problems I faced 
The main bug I have is passing in more than one float values. I can pass a float such as $120.23 once, but when I try to convert another value such as 300.34, the currencyError view appears. Not too sure why it does that. This is why I recommend to only convert whole number values for the app. 








