# Linux x1e-80-100 Dell Latitude 7455
### Snapdragon-Powered Dell Latitude 7455: The Quest for Linux Boot

I have no prior experience with firmware or low-level development — my background is mostly long-term Linux use, almost 20 years, and some basic programming skills.
A few months ago, I got a Dell Latitude 7455 with a Snapdragon X Elite (x1e-80-100), running Windows 11. After digging around online and checking out some interesting projects like [Ubuntu Concept](https://discourse.ubuntu.com/t/ubuntu-24-10-concept-snapdragon-x-elite/48800), [Linaro Debian Installer](https://git.codelinaro.org/linaro/qcomlt/demos/debian-12-installer-image) and others, I started jotting down notes and running a few experiments.
I'll be collecting everything I find or discover here -notes, thoughts, hacks, resources, etc. I'm doing this mostly to learn something cool as I go!

⚠️ _This is very much a work in progress. It's not meant to deliver or release anything — expect rough edges, half-baked ideas, and updates as I go along._

- _06 Jul 2025 New: 🗒️ [On the road](https://github.com/emezeta/linux-x1e80100-dell-l7455/wiki) 🔥_
___
##### Just viewed out there...

 * [Alex Vinarskis - Tributo](https://github.com/alexVinarskis/linux-x1e80100-dell-tributo)
 * [Linux-on-Snapdragon by Jeremiah Hawley](https://github.com/Jeremiah-Hawley/Linux-on-Snapdragon)
 * [Linux support for AArch64 Laptops](https://oftc.irclog.whitequark.org/aarch64-laptops) #aarch64-laptops OFTC irc channel

##### In the press, some specialized news

 * [Dell Latitude 7455 Is The Newest Qualcomm Snapdragon X Elite Laptop Seeing Linux (kernel) Patches](https://www.phoronix.com/news/Dell-Latitude-7455-X1E-Linux) _25/05/2025_

##### EOL reports here?

As  I mentioned earlier, a few months ago I installed a complete base system from [Ubuntu Concept heart Snapdragon X Elite](https://discourse.ubuntu.com/t/ubuntu-concept-snapdragon-x-elite/48800). Images available [here](https://people.canonical.com/~platform/images/ubuntu-concept/).
Ubuntu Concept is a Canonical project that's open to the community.
This experimental system has decent maintenance and updates for a project like this.

I recompile the kernel with some tweaks for my laptop, and huge thanks to [@valpacket](https://github.com/valpackett), who maintains a specific DTB for the Dell Latitude 7455, with ongoing [contributions to the kernel and its ecosystem](https://lore.kernel.org/all/20250525095341.12462-4-val@packett.cool/), for example.

On that same base I've also compiled the kernels from [Linux arm64-laptops](https://gitlab.com/Linaro/arm64-laptops/linux/-/tree/qcom-laptops). Maintained by folks from Linaro/Qualcomm, with a lot of mutual collaboration with the arm64 communities, especially for the latest Snapdragons. They've already adopted a good part of the valpacket-dell-latitude-7455 DTB.
Here too, small tweaks — audio stack tweaks — thanks again to [@valpacket](https://github.com/valpackett).

#
I don't think it's worth continuing this blog. Anyway, if anything interesting comes up, we'll be here. I hope someone else had as much fun as I did ;-) &nbsp;&nbsp;&nbsp;&nbsp;    _02 Apr 2026_

