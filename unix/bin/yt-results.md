# Scripting Youtube-DL Brolen Down Case by Case

So I'm pretty much gonna append the results of running different ytdl commands
here. Make it easy to get the exact command i want.

So far im thinking termux-url-opener is gonna be an if-elif chain with different
youtube commands. 
if they choose something else go to the termux-urls.ipy (or .py by then)

So this is the command i have setup to download 1 url audio only
youtube-dl --no-mtime -o "/data/data/com.termux/files/home/storage/shared/music/%(title)s.%(ext)s" -f "bestaudio" $1;;

It doesn't pick up the metadata correctly at all unfortunately. however i
think theres an option that can fix that.

--add-metadata
don't know how it works but whatever.

--metadata-from-title FORMAT
is another way but there we go with the regular expressions

oh also that title is long as balls and doesn't even change so probably do some

dl=/path/to/file

case:
    //logic
esac

unset dl

or something

damn this was a huge amount of talking and no results so far!!

lets get to it.

Downloading 1 video with metadata in Videos [make sure to change music to Music]

u0_a144@localhost:~/projects/dotfiles/unix/bin (master *)$ youtube-dl --no-mtime -o "/data/data/com.termux/files/home/storage/shared/music/%(title)s.%(ext)s" -F --add-metadata https://youtu.be/Oz_-VaTHpc8
[youtube] Oz_-VaTHpc8: Downloading webpage
[youtube] Oz_-VaTHpc8: Downloading video info webpage
[youtube] Oz_-VaTHpc8: Extracting video information
[youtube] Oz_-VaTHpc8: Downloading js player vfl5ItJAe
[info] Available formats for Oz_-VaTHpc8:
format code  extension  resolution note
249          webm       audio only DASH audio   53k , opus @ 50k, 1.25MiB
250          webm       audio only DASH audio   70k , opus @ 70k, 1.65MiB
171          webm       audio only DASH audio  124k , vorbis@128k, 2.90MiB
140          m4a        audio only DASH audio  128k , m4a_dash container, mp4a.40.2@128k, 3.19MiB
251          webm       audio only DASH audio  140k , opus @160k, 3.20MiB
278          webm       192x144    144p   73k , webm container, vp9, 24fps, video only, 1.70MiB
160          mp4        192x144    144p   86k , avc1.4d400b, 24fps, video only, 1.92MiB
242          webm       320x240    240p  168k , vp9, 24fps, video only, 3.82MiB
133          mp4        320x240    240p  187k , avc1.4d400d, 24fps, video only, 3.85MiB
243          webm       480x360    360p  306k , vp9, 24fps, video only, 6.71MiB
134          mp4        480x360    360p  479k , avc1.4d4015, 24fps, video only, 9.26MiB
244          webm       640x480    480p  576k , vp9, 24fps, video only, 11.87MiB
135          mp4        640x480    480p  879k , avc1.4d401e, 24fps, video only, 17.18MiB
17           3gp        176x144    small , mp4v.20.3, mp4a.40.2@ 24k
36           3gp        320x240    small , mp4v.20.3, mp4a.40.2
18           mp4        480x360    medium , avc1.42001E, mp4a.40.2@ 96k
43           webm       640x360    medium , vp8.0, vorbis@128k (best)
u0_a144@localhost:~/projects/dotfiles/unix/bin (master *)$ youtube-dl --no-mtime -o "/data/data/com.termux/files/home/storage/shared/Videos/%(title)s.%(ext)s"  --add-metadata https://youtu.be/Oz_-VaTHpc8
[youtube] Oz_-VaTHpc8: Downloading webpage
[youtube] Oz_-VaTHpc8: Downloading video info webpage
[youtube] Oz_-VaTHpc8: Extracting video information
WARNING: Requested formats are incompatible for merge and will be merged into mkv.
[download] Destination: /data/data/com.termux/files/home/storage/shared/Videos/JAY-Z - Dirt Off Your Shoulder.f135.mp4
[download] 100% of 17.18MiB in 00:02
[download] Destination: /data/data/com.termux/files/home/storage/shared/Videos/JAY-Z - Dirt Off Your Shoulder.f251.webm
[download] 100% of 3.20MiB in 00:00
[ffmpeg] Merging formats into "/data/data/com.termux/files/home/storage/shared/Videos/JAY-Z - Dirt Off Your Shoulder.mkv"
Deleting original file /data/data/com.termux/files/home/storage/shared/Videos/JAY-Z - Dirt Off Your Shoulder.f135.mp4 (pass -k to keep)
Deleting original file /data/data/com.termux/files/home/storage/shared/Videos/JAY-Z - Dirt Off Your Shoulder.f251.webm (pass -k to keep)
[ffmpeg] Adding metadata to '/data/data/com.termux/files/home/storage/shared/Videos/JAY-Z - Dirt Off Your Shoulder.mkv'





now downloading a song with metadata

u0_a144@localhost:~/projects/dotfiles/unix/bin (master *)$ youtube-dl --no-mtime -o "/data/data/com.termux/files/home/storage/shared/Music/%(title)s.%(ext)s" --metadata-from-title "%(artist)s - %(title)s" --add-metadata -x --audio-format best --embed-thumbnail https://youtu.be/8HBTiDD9BCA
[youtube] 8HBTiDD9BCA: Downloading webpage
[youtube] 8HBTiDD9BCA: Downloading video info webpage
[youtube] 8HBTiDD9BCA: Extracting video information
[youtube] 8HBTiDD9BCA: Downloading thumbnail ...
[youtube] 8HBTiDD9BCA: Writing thumbnail to: /data/data/com.termux/files/home/storage/shared/Music/Lucifer (Explicit).jpg
[download] Destination: /data/data/com.termux/files/home/storage/shared/Music/Lucifer (Explicit).webm
[download] 100% of 3.03MiB in 00:00
[fromtitle] Could not interpret title of video as "%(artist)s - %(title)s"
[ffmpeg] Destination: /data/data/com.termux/files/home/storage/shared/Music/Lucifer (Explicit).opus
Deleting original file /data/data/com.termux/files/home/storage/shared/Music/Lucifer (Explicit).webm (pass -k to keep)
[ffmpeg] Adding metadata to '/data/data/com.termux/files/home/storage/shared/Music/Lucifer (Explicit).opus'
ERROR: Only mp3 and m4a/mp4 are supported for thumbnail embedding for now.
u0_a144@localhost:~/projects/dotfiles/unix/bin (master *)$


i got "Jay-Z (Topic)" as an artist but whatever.
still playing with it. worst come to worst we use some re magic!!


ran this command:
u0_a144@localhost:~/projects/dotfiles/unix/bin (master *)$ youtube-dl --no-mtime -o "/data/data/com.termux/files/home/storage/shared/Music/%(title)s.%(ext)s" --metadata-from-title "%(artist)s - %(title)s" --add-metadata -x --audio-format best https://youtu.be/xufJHc2EdBA >> yt-results.test


[youtube] xufJHc2EdBA: Downloading webpage
[youtube] xufJHc2EdBA: Downloading video info webpage
[youtube] xufJHc2EdBA: Extracting video information
[download] Destination: /data/data/com.termux/files/home/storage/shared/Music/Big Sean - Control f. Kendrick Lamar & Jay Electronica.webm

[fromtitle] parsed artist: Big Sean
[fromtitle] parsed title: Control f. Kendrick Lamar & Jay Electronica
[ffmpeg] Destination: /data/data/com.termux/files/home/storage/shared/Music/Big Sean - Control f. Kendrick Lamar & Jay Electronica.ogg
Deleting original file /data/data/com.termux/files/home/storage/shared/Music/Big Sean - Control f. Kendrick Lamar & Jay Electronica.webm (pass -k to keep)
[ffmpeg] Adding metadata to '/data/data/com.termux/files/home/storage/shared/Music/Big Sean - Control f. Kendrick Lamar & Jay Electronica.ogg'







[youtube] cykGnl1KvcM: Downloading webpage
[youtube] cykGnl1KvcM: Downloading video info webpage
[youtube] cykGnl1KvcM: Extracting video information
[youtube] cykGnl1KvcM: Downloading webpage
[youtube] cykGnl1KvcM: Downloading video info webpage
[youtube] cykGnl1KvcM: Extracting video information
[info] Available formats for cykGnl1KvcM:
format code  extension  resolution note
249          webm       audio only DASH audio   58k , opus @ 50k, 1.39MiB
250          webm       audio only DASH audio   81k , opus @ 70k, 1.89MiB
171          webm       audio only DASH audio  121k , vorbis@128k, 2.91MiB
140          m4a        audio only DASH audio  128k , m4a_dash container, mp4a.40.2@128k, 3.31MiB
251          webm       audio only DASH audio  154k , opus @160k, 3.58MiB
160          mp4        192x144    144p   11k , avc1.4d400b, 25fps, video only, 237.41KiB
133          mp4        320x240    240p   19k , avc1.4d400d, 25fps, video only, 364.42KiB
278          webm       192x144    144p   31k , webm container, vp9, 13fps, video only, 533.18KiB
134          mp4        480x360    360p   44k , avc1.4d4015, 25fps, video only, 781.52KiB
242          webm       320x240    240p   58k , vp9, 25fps, video only, 990.29KiB
135          mp4        640x480    480p   82k , avc1.4d401e, 25fps, video only, 1.41MiB
243          webm       480x360    360p   94k , vp9, 25fps, video only, 1.55MiB
244          webm       640x480    480p  148k , vp9, 25fps, video only, 2.41MiB
17           3gp        176x144    small , mp4v.20.3, mp4a.40.2@ 24k
36           3gp        320x240    small , mp4v.20.3, mp4a.40.2
18           mp4        480x360    medium , avc1.42001E, mp4a.40.2@ 96k
43           webm       640x360    medium , vp8.0, vorbis@128k (best)




[youtube] cykGnl1KvcM: Downloading webpage
[youtube] cykGnl1KvcM: Downloading video info webpage
[youtube] cykGnl1KvcM: Extracting video information
[download] Destination: /data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - I Feel Like Dying.f244.webm

[download] Destination: /data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - I Feel Like Dying.f251.webm

[ffmpeg] Merging formats into "/data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - I Feel Like Dying.webm"
Deleting original file /data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - I Feel Like Dying.f244.webm (pass -k to keep)
Deleting original file /data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - I Feel Like Dying.f251.webm (pass -k to keep)
[fromtitle] parsed artist: Lil Wayne
[fromtitle] parsed title: I Feel Like Dying
[ffmpeg] Adding metadata to '/data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - I Feel Like Dying.webm'







[youtube] skN5U4dlmrE: Downloading webpage
[youtube] skN5U4dlmrE: Downloading video info webpage
[youtube] skN5U4dlmrE: Extracting video information
[youtube] skN5U4dlmrE: Downloading js player vfluI_BcD
[download] Destination: /data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - Hollyweezy (Official Music Video).f137.mp4

[download] Destination: /data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - Hollyweezy (Official Music Video).f251.webm

[ffmpeg] Merging formats into "/data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - Hollyweezy (Official Music Video).mkv"
Deleting original file /data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - Hollyweezy (Official Music Video).f137.mp4 (pass -k to keep)
Deleting original file /data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - Hollyweezy (Official Music Video).f251.webm (pass -k to keep)
[fromtitle] parsed artist: Lil Wayne
[fromtitle] parsed title: Hollyweezy (Official Music Video)
[ffmpeg] Adding metadata to '/data/data/com.termux/files/home/storage/shared/Music/Lil Wayne - Hollyweezy (Official Music Video).mkv'


# COMMAND THAT WORKS
# DOWNLOAD MP3 WITH PROPER METADATA
Now that we have a functional command it'll be trivial to remove 
"-x --audio-format mp3" so we download a video [test if we need to pass -k or
not] and then we can get a playlist version and we're gucci!

u0_a144@localhost:~/projects/dotfiles/unix/bin (termux *)$ youtube-dl --no-mtime -o "/data/data/com.termux/files/home/storage/shared/Music/%(title)s.%(ext)s" --metadata-from-title "%(artist)s - %(title)s" --add-metadata -x --audio-format mp3 --prefer-ffmpeg https://youtu.be/Y4QVpt0Ikdg  >> yt-results.md


[youtube] Y4QVpt0Ikdg: Downloading webpage
[youtube] Y4QVpt0Ikdg: Downloading video info webpage
[youtube] Y4QVpt0Ikdg: Extracting video information
[download] Destination: /data/data/com.termux/files/home/storage/shared/Music/kendrick lamar & J. cole - Black Friday (lyrics).webm

[fromtitle] parsed artist: kendrick lamar & J. cole
[fromtitle] parsed title: Black Friday (lyrics)
[ffmpeg] Destination: /data/data/com.termux/files/home/storage/shared/Music/kendrick lamar & J. cole - Black Friday (lyrics).mp3
Deleting original file /data/data/com.termux/files/home/storage/shared/Music/kendrick lamar & J. cole - Black Friday (lyrics).webm (pass -k to keep)
[ffmpeg] Adding metadata to '/data/data/com.termux/files/home/storage/shared/Music/kendrick lamar & J. cole - Black Friday (lyrics).mp3'




## Videos no playlist

[youtube] abrcJ9MpF60: Downloading webpage
[youtube] abrcJ9MpF60: Downloading video info webpage
[youtube] abrcJ9MpF60: Extracting video information
[download] Destination: /data/data/com.termux/files/home/storage/shared/Videos/Al Sweigart   Yes, It's Time to Learn Regular Expressions   PyCon 2017.mp4

[fromtitle] Could not interpret title of video as "%(artist)s - %(title)s"
[ffmpeg] Adding metadata to '/data/data/com.termux/files/home/storage/shared/Videos/Al Sweigart   Yes, It's Time to Learn Regular Expressions   PyCon 2017.mp4'