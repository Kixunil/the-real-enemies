# The Real Enemies

Factorio mod showing and automating ellimination of the real enemies.

**Dear content creators, please do not spoil your audience without a warning!**

## About

There's only one visible interface in the game: "Discover the real enemies" technology.
Once you research this technology the real enemies are shown on the map as red dots and your turrets (including artilery) will attack them automatically when in range.
The research requires unlocking Automation, Logistic Science Pack, and Military first and takes 100 of red and green science packs for 60s.
Using with the [Nuclear Artilery Shell] mod is more fun but I recommend saving the game before completing the research.

Recommended for beginners who don't know the real enemies yet and want to learn (probably start a new game though)
and advanced players who know already and just want to get rid of the real enemies more quickly.

<details>
<summary>SPOILER!!! Who the real enemies are?</summary>

Trees, obviously. The mod makes turrets attack trees.
</details>

## Technical details - how it works

<details>
<summary>SPOILER!!! It's hard to explain without spoling</summary>

Once the technology is researched an invisible entity with `force = "enemy"` is placed at the position of each already generated tree and on event when a new chunk is generated.
When either tree or the entity is damaged the health value is synced so that the player cannot see the difference.
When either tree or the entity is destroyed the other is destroyed too.

Note to other modders: calling `.destroy()` on trees or dummy entities will lead to buggy behavior.
Call `.die()` instead.

Yes, I know about registering `on_entity_destroyed` event and tried it. It froze the whole game and I didn't figure out how to fix it.
Probably a deadlock due to reentrancy.  Feel free to send a PR if you know how to fix it.
</details>

## Mod compatibility

The real enemies should, in principle, be attacked by turrets from all mods.
You might experience issues if any mod is using the `.destroy()` method on entities it didn't create.
That is a bad idea anyway, so such should be unlikely.

That being said none of this was tested apart from [Nuclear Artilery Shell] which works perfectly.

## License

MIT

Plus you agree to being shamed for spoiling who the real enemies are without a warning.

[Nuclear Artilery Shell]: https://mods.factorio.com/mod/Nuclear_Artillery_Shell
