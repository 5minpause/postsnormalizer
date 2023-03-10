# Posts Normalizer

A small Ruby script thingy I wrote to add `permalinks` to the frontmatter of all markdown posts living in subfolders inside a posts folder.
I used this to migrate my GatsbyJS site to [micro.blog](https://micro.blog).
Micro.blog expects a ZIP file with markdown files. If you want to have redirects set up to your old posts, you will need permalinks.
My old site had posts like holgerfrohloff.de/power-laws. Byt adding a permalink `permalink: "/power-laws"` to the frontmatter, Micro.blog will setup redirects properly.

## How to use

I ran it inside a Ruby console. 

```bash
$ irb
# => starts a interacctive Ruby console
irb(main):001:0> require_relative "./lib/normalizer.rb"
irb(main):002:0> Normalizer.for_path("path/to/your/gatsby-site/content/posts")
irb(main):003:0> exit
```

This will put lots of markdown files into the `path/to/your/gatsby-site/content/posts` folder. All you need to do now is ZIP them and upload/import to your Micro.blog.
