# swift-html-research

## Measurement

1000 runs on Macbook iPhone 13 __Simulator__ from tests target

<img width="584" alt="Screenshot 2022-08-19 at 14 25 05" src="https://user-images.githubusercontent.com/4246455/185588885-2c41ef9e-912d-44b5-b613-428fcc67e95d.png">

## Decision

### #1 - [Bonmot](https://github.com/Rightpoint/BonMot.git)

not the fastest, but is
- maintained
- allows to configure tags inside tags
- uses xml parser for all tags


Minus of all libraries is one
- supports only tags that are defined in code. It is possible to make dynamic styling, but costs dev time.


### #2-3-4 Atributika, Ashton, SwiftRichString

Atributika doesn't support tags in tags. `<b><i><s>text</s></i></b>` would become only strikethrough

Ashton doesn't seem to be configurable in terms of styling (or I don't see it :))

SwiftRichString last release is 2020
