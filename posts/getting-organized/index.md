---
date: 2026-07-18
title: Getting Organized
---


<img alt="boxes wide"
     src="https://images.jan.tf/e6v9FyEbAvpv2z0nIpDSPa14UUs2h_cdb_2BsVx8nTo/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvYm94ZXMtd2lkZS5qcGc"
     srcset="https://images.jan.tf/zqOV1tKu3KtcrUzMQckpol8l1-8-DRNioOl80u1xINw/el:t/g:no/rt:fit/w:480/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvYm94ZXMtd2lkZS5qcGc 480w,
         https://images.jan.tf/0k1O4JvlO_GPEP2uOF_XV2HJ-KXUnkrdyO2SXG0OXy4/el:t/g:no/rt:fit/w:800/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvYm94ZXMtd2lkZS5qcGc 800w,
         https://images.jan.tf/e6v9FyEbAvpv2z0nIpDSPa14UUs2h_cdb_2BsVx8nTo/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvYm94ZXMtd2lkZS5qcGc 1200w,
         https://images.jan.tf/rrL4Jx-8V4tatjVTe-U8Xgs92vWdNrpMOCsmo7icpAQ/el:t/g:no/rt:fit/w:1600/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvYm94ZXMtd2lkZS5qcGc 1600w"
     sizes="(max-width: 800px) 100vw, 800px">

I'm a bit of a hoarder when it comes to side projects, it seems that I have a compulsion to start new ones halfway finishing another.
While I haven't been diagnosed with ADD or ADHD, it does make you wonder.

I also have a tendency to impulse buy components for electronics projects I haven't imagined yet, or I salvage parts from old electronics.
For finished projects there are always extras, after all you don't buy a single resistor.
What has happend over the years is that my collection has grown and I have no idea what I have. What's worse I don't know the specs of some parts (or pinouts, or dimensions for CAD).
I'm lucky if I can find this from the store page where I bought the part in the first place, but these go offline over the years.



Time to get organized (and start yet another side project).
There are existing inventory management solutions like [HomeBox](https://homebox.software/) which seems pretty good, but I feel that I would be too lazy to click through the UI and add all my things.
I much rather have a coding agent take care of this for me, and while I could give one access to the HomeBox API, I would prefer something more auditable and reversible.

I decided to use [Thalo](https://thalo.rejot.dev/) instead, which is `a plain-text, structured format for capturing knowledge` inspired by text based accounting software [Beancount](https://github.com/beancount/beancount). 

You define entities that can be type-checked and queried.
Because it is text based, it is very easy for LLMs to generate multiple new entries and I can simply use Git(Hub) to keep track of what is changing over time.

For my inventory management system I have three core entities: `items`, `purchases` and `locations`.
Items are any kind of object I want to track in the system, purchases for prices and stores where I bought them (if applicable) and locations for locating an item.
Items can reference location or purchase entries through slugs/ids which the Thalo cli checks to make sure they actually exist.

Below you'll find an abbreviated example:

```bash
create item "MP1584EN DC-DC buck converter" ^buck-mp1584en looooooooooooooooooooooooooong
  category: "module"
  part-number: "MP1584EN"
  quantity: 6
  location: ^sb1

  # Specs
  ...
```

Note that we reference the location with slug `sb1`, this links to the following location entry:
```bash
create location "Small black assortment box 1" ^sb1
  kind: "box"
  label: "SB-1"
```

Besides what you see here, I also keep track of item CAD models (stl/step files), quick specification, links to datasheet, pinout tables, inlined user guides and personal notes.

The beauty of this system is that I can give my coding agent a PDF invoice, and have it  automatically fetch whatever information I want to track and then review using git.

## A UI

Next up I wanted to make this information in my inventory more accessible, I sometimes design things with CAD on my iPad while on the go so it would be nice to be able to reference items from anywhere.

To turn my inventory into a static site, I simply plugged it into an [Astro.build](https://astro.build/) content collection using Thalos' scripting API.
The page itself is very simple, a table with all items and filters for categories and locations and a detail pages for each item.

<figure>
    <picture>
        <source media="(prefers-color-scheme: light)" srcset="/posts/getting-organized/list-light.png">
        <source media="(prefers-color-scheme: dark)" srcset="/posts/getting-organized/list-dark.png">
        <img alt="Screenshot" src="/posts/getting-organized/list-light.png">
    </picture>
    <figcaption>Item list view</figcaption>
</figure>

<figure>
    <picture>
        <source media="(prefers-color-scheme: light)" srcset="/posts/getting-organized/detail-light.png">
        <source media="(prefers-color-scheme: dark)" srcset="/posts/getting-organized/detail-dark.png">
        <img alt="Screenshot" src="/posts/getting-organized/detail-light.png">
    </picture>
    <figcaption>Item detail view</figcaption>
</figure>

## Designing with this system
thalo query, agent suggestions, electronics questions

## Finishing touches

I label my assortment boxes using a Dymo embossed label maker, I also found a matching [Dymo font](https://www.dafont.com/dymo.font) that replicates the look of these labels.
Now my labels IRL match the ones in the inventory system.


![Dymo labels IRL](https://images.jan.tf/VgpRNrhCBd9_L9922X6I6Yp80vQ4jrlRwDUaLgScAXU/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvbGFiZWwtY2xvc2V1cC5qcGc)


## Cleanup

![Empty desk](https://images.jan.tf/PCkir8ng5JpN142C3qD9awtQScOStCWWmqXcRdZp8LM/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvZW1wdHktZGVzay5qcGc)


## All Images

<img alt="boxes closeup"
     src="https://images.jan.tf/1BNreps0RWJlAUYm_tKpasQk2ATSEfd68p1UoGaAMBM/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvYm94ZXMtY2xvc2V1cC5qcGc"
     srcset="https://images.jan.tf/pvlAXU6JzeThG5b6N_3vhg1iZ0-wbfXBhln3jvSxvI0/el:t/g:no/rt:fit/w:480/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvYm94ZXMtY2xvc2V1cC5qcGc 480w,
         https://images.jan.tf/rTSIMWyDAzV2hayY0tOQg2p7Uf88F6CCDaustQouT_0/el:t/g:no/rt:fit/w:800/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvYm94ZXMtY2xvc2V1cC5qcGc 800w,
         https://images.jan.tf/1BNreps0RWJlAUYm_tKpasQk2ATSEfd68p1UoGaAMBM/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvYm94ZXMtY2xvc2V1cC5qcGc 1200w,
         https://images.jan.tf/91upIIH9skNMyXejH2a1DyqW7fGLV82dWc2W_jzJGOc/el:t/g:no/rt:fit/w:1600/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvYm94ZXMtY2xvc2V1cC5qcGc 1600w"
     sizes="(max-width: 800px) 100vw, 800px">

<img alt="boxes wide"
     src="https://images.jan.tf/e6v9FyEbAvpv2z0nIpDSPa14UUs2h_cdb_2BsVx8nTo/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvYm94ZXMtd2lkZS5qcGc"
     srcset="https://images.jan.tf/zqOV1tKu3KtcrUzMQckpol8l1-8-DRNioOl80u1xINw/el:t/g:no/rt:fit/w:480/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvYm94ZXMtd2lkZS5qcGc 480w,
         https://images.jan.tf/0k1O4JvlO_GPEP2uOF_XV2HJ-KXUnkrdyO2SXG0OXy4/el:t/g:no/rt:fit/w:800/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvYm94ZXMtd2lkZS5qcGc 800w,
         https://images.jan.tf/e6v9FyEbAvpv2z0nIpDSPa14UUs2h_cdb_2BsVx8nTo/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvYm94ZXMtd2lkZS5qcGc 1200w,
         https://images.jan.tf/rrL4Jx-8V4tatjVTe-U8Xgs92vWdNrpMOCsmo7icpAQ/el:t/g:no/rt:fit/w:1600/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvYm94ZXMtd2lkZS5qcGc 1600w"
     sizes="(max-width: 800px) 100vw, 800px">

<img alt="empty desk"
     src="https://images.jan.tf/PCkir8ng5JpN142C3qD9awtQScOStCWWmqXcRdZp8LM/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvZW1wdHktZGVzay5qcGc"
     srcset="https://images.jan.tf/QJCe4eFmiiFJMup9w2fT4gKLDRwFBtFFkfsZvvzNCgA/el:t/g:no/rt:fit/w:480/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvZW1wdHktZGVzay5qcGc 480w,
         https://images.jan.tf/G9CJkThKQHoNOEuPy0acoMDTPNbxyBEquPvK34LwnJQ/el:t/g:no/rt:fit/w:800/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvZW1wdHktZGVzay5qcGc 800w,
         https://images.jan.tf/PCkir8ng5JpN142C3qD9awtQScOStCWWmqXcRdZp8LM/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvZW1wdHktZGVzay5qcGc 1200w,
         https://images.jan.tf/VrBNrEx_7MbjaXHG8EVm9EOGF19PpoDgmebBHfcHQt4/el:t/g:no/rt:fit/w:1600/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvZW1wdHktZGVzay5qcGc 1600w"
     sizes="(max-width: 800px) 100vw, 800px">

<img alt="label closeup"
     src="https://images.jan.tf/VgpRNrhCBd9_L9922X6I6Yp80vQ4jrlRwDUaLgScAXU/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvbGFiZWwtY2xvc2V1cC5qcGc"
     srcset="https://images.jan.tf/tb0tZ9rdUirx2UsUml1mDyIkdEgNehPDfLD8VQOTEgE/el:t/g:no/rt:fit/w:480/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvbGFiZWwtY2xvc2V1cC5qcGc 480w,
         https://images.jan.tf/WwLdP3e1VmpGfNyiDavDU2cwH0YuYd2jekU4zWrMWnQ/el:t/g:no/rt:fit/w:800/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvbGFiZWwtY2xvc2V1cC5qcGc 800w,
         https://images.jan.tf/VgpRNrhCBd9_L9922X6I6Yp80vQ4jrlRwDUaLgScAXU/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvbGFiZWwtY2xvc2V1cC5qcGc 1200w,
         https://images.jan.tf/T9xWZISnCnICiXKGxwgu2cSHRNt_t1P1bsHgEP95MG8/el:t/g:no/rt:fit/w:1600/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvbGFiZWwtY2xvc2V1cC5qcGc 1600w"
     sizes="(max-width: 800px) 100vw, 800px">
