---
date: 2026-07-18
title: "Getting organized: personal inventory management"
---

<img alt="various colored assortment boxes laid out on my workbench"
     src="https://images.jan.tf/e6v9FyEbAvpv2z0nIpDSPa14UUs2h_cdb_2BsVx8nTo/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvYm94ZXMtd2lkZS5qcGc"
     srcset="https://images.jan.tf/zqOV1tKu3KtcrUzMQckpol8l1-8-DRNioOl80u1xINw/el:t/g:no/rt:fit/w:480/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvYm94ZXMtd2lkZS5qcGc 480w,
         https://images.jan.tf/0k1O4JvlO_GPEP2uOF_XV2HJ-KXUnkrdyO2SXG0OXy4/el:t/g:no/rt:fit/w:800/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvYm94ZXMtd2lkZS5qcGc 800w,
         https://images.jan.tf/e6v9FyEbAvpv2z0nIpDSPa14UUs2h_cdb_2BsVx8nTo/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvYm94ZXMtd2lkZS5qcGc 1200w,
         https://images.jan.tf/rrL4Jx-8V4tatjVTe-U8Xgs92vWdNrpMOCsmo7icpAQ/el:t/g:no/rt:fit/w:1600/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvYm94ZXMtd2lkZS5qcGc 1600w"
     sizes="(max-width: 800px) 100vw, 800px">

I've been hoarding various electrical components/modules over the years, either salvaged from old devices, extras from projects or impulse-buying things that I _might_ be able to use in the future.
Today my collection has grown big enough that I no longer have an overview of what I have.

What's worse is I don't remember most of the specs of my components, simple things like pinouts or what voltages it operates on.
I find myself often looking up the original reseller's listing of an item, just to make sure I get the right details. Sometimes knock-off components have different specs from the real ones, so I tend to go from the store page.
The problem there is of course that these pages go offline over the years.

I decided to put some kind of system in place for tracking what I have.
There are existing inventory management solutions like [HomeBox](https://homebox.software/) which seems pretty good, but I am too lazy to click through the UI and add all my things individually.
I'd much rather have some LLM agent take care of this for me, I could of course give one access to the HomeBox API, but then I could not easily audit or revert what the agent is doing.

## Plain-text knowledge base

Instead I opted for [Thalo](https://thalo.rejot.dev/), a "plain-text, structured format for capturing knowledge" inspired by the text based accounting language [Beancount](https://github.com/beancount/beancount).
It's a simple human readable format, consisting of `entities`, `entries`, `links` and `syntheses` (this last one I don't use here).
Your `entities` are basically the schema of your knowledge base, and the `entries` the actual rows. Thalo checks the schema of your entries and cross-references your links to make sure your knowledge base is consistent.
It's made to be used in conjunction with LLMs, as those prefer text as an interface but need _some_ guardrails to keep them from messing up.
Thalo also works well with Git, which makes everything auditable and reversible.

For my inventory management system I have three entities:

- `items`: any kind of object I want to track in my inventory
- `purchases`: track prices and retailers
- `locations`: where an item is located

An entry looks something like this (abbreviated):

```bash
create item "MP1584EN DC-DC buck converter" ^buck-mp1584en
  category: "module"
  part-number: "MP1584EN"
  quantity: 6
  location: ^sb1

  # Specs
  Input: 4.5–24 V
  Output: 0.8–17 V
  ...
```

Besides what you see here, I also keep track of CAD models (stl/step files), links to datasheets, pinout tables, user guides and my personal notes.

The beauty of this system is that I can give my coding agent a PDF invoice, and have it find all the information I need automatically then review all new entries at once.

## Storage

Most of my components are stored in plastic assortment boxes. I have a simple system for labelling these boxes: size (t-shirt sizes) + color + N.
I add the labels with a Dymo embossed label maker, which has a nice aesthetic.

<img alt="Closeup of three assortment boxes with their Dymo labels"
     src="https://images.jan.tf/VgpRNrhCBd9_L9922X6I6Yp80vQ4jrlRwDUaLgScAXU/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvbGFiZWwtY2xvc2V1cC5qcGc"
     srcset="https://images.jan.tf/tb0tZ9rdUirx2UsUml1mDyIkdEgNehPDfLD8VQOTEgE/el:t/g:no/rt:fit/w:480/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvbGFiZWwtY2xvc2V1cC5qcGc 480w,
         https://images.jan.tf/WwLdP3e1VmpGfNyiDavDU2cwH0YuYd2jekU4zWrMWnQ/el:t/g:no/rt:fit/w:800/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvbGFiZWwtY2xvc2V1cC5qcGc 800w,
         https://images.jan.tf/VgpRNrhCBd9_L9922X6I6Yp80vQ4jrlRwDUaLgScAXU/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvbGFiZWwtY2xvc2V1cC5qcGc 1200w,
         https://images.jan.tf/T9xWZISnCnICiXKGxwgu2cSHRNt_t1P1bsHgEP95MG8/el:t/g:no/rt:fit/w:1600/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvbGFiZWwtY2xvc2V1cC5qcGc 1600w"
     sizes="(max-width: 800px) 100vw, 800px">

Note that I reference the location above with slug `sb1`, which corresponds to the following `location` entry in Thalo:

```bash
create location "Small black assortment box 1" ^sb1
  kind: "box"
  label: "SB-1"
```

Thalo also has a query language that you or your agent can use for finding an item:

```bash
$ thalo query 'item where location = ^sr1'

Query: item where location = ^sr1
Found: 1 entries

2026-06-22T10:01Z item DFRobot DFPlayer Mini — MP3 module ^dfplayer-mini #audio
  items/modules.thalo:1-47
```

## Adding an interface

Sometimes I design things with CAD on my iPad while on the go, and being able to reference something quickly anywhere would be great, so I decided to add a simple webpage.

Luckily Thalo has a [scripting API](https://thalo.rejot.dev/docs/scripting) that you can plug into a static site generator.
I opted for [Astro.build](https://astro.build/) because, like Thalo, it has a TypeScript interface.
When I commit new entries to the inventory, I have [Dokploy](https://dokploy.com/) rebuild and deploy automatically.

<img alt="Screenshot of a browser window showing a table of inventory items"
     src="https://images.jan.tf/UoY9rEXZkNFA8ikRTowmFjNc4QvbBdJJv9S6Q0Bl-84/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvaW52ZW50b3J5LWxpc3QucG5n"
     srcset="https://images.jan.tf/XQabSui1GtfuVyutVU3bu4rElLt5OzbEsGQNEMH5T5o/el:t/g:no/rt:fit/w:480/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvaW52ZW50b3J5LWxpc3QucG5n 480w,
         https://images.jan.tf/pWkJZFs3LYo0mwbUUOgtkCoSO3g00fyYsbzVB9NWVoM/el:t/g:no/rt:fit/w:800/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvaW52ZW50b3J5LWxpc3QucG5n 800w,
         https://images.jan.tf/UoY9rEXZkNFA8ikRTowmFjNc4QvbBdJJv9S6Q0Bl-84/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvaW52ZW50b3J5LWxpc3QucG5n 1200w,
         https://images.jan.tf/ktGPwrwtrZ-5TmgXWYdgx1cjMEMa11X1FrxOz0ZOTcg/el:t/g:no/rt:fit/w:1600/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvaW52ZW50b3J5LWxpc3QucG5n 1600w"
     sizes="(max-width: 800px) 100vw, 800px">

You can see that I've included some filtering in the frontend for quick navigation, but the site always loads the whole inventory at once.

<img alt="Screenshot of a browser window showing a specific inventory item"
     src="https://images.jan.tf/dWVl8B4YQ9LGbRST35mpieZ8IoL5Keg9GmnnKScHqbA/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvaW52ZW50b3J5LWl0ZW0ucG5n"
     srcset="https://images.jan.tf/Ghv_sW7d8CnW0gJTb50t5SNwAtXwukH4WJWNPfSYkPY/el:t/g:no/rt:fit/w:480/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvaW52ZW50b3J5LWl0ZW0ucG5n 480w,
         https://images.jan.tf/uD__lp6PtSuhc3eLDmMbhBvr7LSUT2jVTbZvpNykYqU/el:t/g:no/rt:fit/w:800/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvaW52ZW50b3J5LWl0ZW0ucG5n 800w,
         https://images.jan.tf/dWVl8B4YQ9LGbRST35mpieZ8IoL5Keg9GmnnKScHqbA/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvaW52ZW50b3J5LWl0ZW0ucG5n 1200w,
         https://images.jan.tf/dEc1EnT696qMaayJsayv66Cz48j19v8_DP1yHqWcExo/el:t/g:no/rt:fit/w:1600/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvaW52ZW50b3J5LWl0ZW0ucG5n 1600w"
     sizes="(max-width: 800px) 100vw, 800px">

I found [a font](https://www.dafont.com/dymo.font) that matches the look of the Dymo embossed labels that I now also use in the webpage, totally unnecessary but adds a nice touch.

I'm currently using this system, and it has basically all features I need.
I haven't logged everything I own yet however, while it's trivial to add new purchases, adding salvaged items is still a lot of manual work.

Sadly I can't open source this project, given that the knowledge base contains personal payment information and serves images which I do not have the rights to.

Reach out to me on `blog[at]jan.tf` if you need any help to set up the same thing.

<center>···</center>

<img alt="empty desk"
     src="https://images.jan.tf/PCkir8ng5JpN142C3qD9awtQScOStCWWmqXcRdZp8LM/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvZW1wdHktZGVzay5qcGc"
     srcset="https://images.jan.tf/QJCe4eFmiiFJMup9w2fT4gKLDRwFBtFFkfsZvvzNCgA/el:t/g:no/rt:fit/w:480/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvZW1wdHktZGVzay5qcGc 480w,
         https://images.jan.tf/G9CJkThKQHoNOEuPy0acoMDTPNbxyBEquPvK34LwnJQ/el:t/g:no/rt:fit/w:800/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvZW1wdHktZGVzay5qcGc 800w,
         https://images.jan.tf/PCkir8ng5JpN142C3qD9awtQScOStCWWmqXcRdZp8LM/el:t/g:no/rt:fit/w:1200/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvZW1wdHktZGVzay5qcGc 1200w,
         https://images.jan.tf/VrBNrEx_7MbjaXHG8EVm9EOGF19PpoDgmebBHfcHQt4/el:t/g:no/rt:fit/w:1600/bG9jYWw6Ly8vcG9zdHMvZ2V0dGluZy1vcmdhbml6ZWQvZW1wdHktZGVzay5qcGc 1600w"
     sizes="(max-width: 800px) 100vw, 800px">
