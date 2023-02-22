---
editor_options: 
  markdown: 
    wrap: 72
---

## First sumbission

The purpose of this package is to ship with a large survey dataset and
provide functions to aggregate it to more usuable forms. As such, it has
a large \~8Mb internal dataset, which is the source of some of these
notes.

Looking forward to the feedback.

Thanks! David

## Test environments

-   R-hub windows-x86_64-devel (r-devel)
-   R-hub ubuntu-gcc-release (r-release)
-   R-hub fedora-clang-devel (r-devel)

## R CMD check results

0 errors ✔ \| 0 warnings ✔ \| 6 notes ✖

I have addressed each Note below.

### Note 1:

❯ On windows-x86_64-devel (r-devel), ubuntu-gcc-release (r-release)
checking CRAN incoming feasibility ... NOTE Maintainer: 'David Hammond
[dhammond\@economicsandpeace.org](mailto:dhammond@economicsandpeace.org){.email}'

New submission

Size of tarball: 8806060 bytes

According to
[Stackoverflow](https://stackoverflow.com/questions/23829978/checking-cran-incoming-feasibility-note-maintainer),
this message can be ignored.

### Note 2:

❯ On windows-x86_64-devel (r-devel), ubuntu-gcc-release (r-release),
fedora-clang-devel (r-devel) checking installed package size ... NOTE
installed size is 8.5Mb sub-directories of 1Mb or more: R 8.4Mb

As noted in [Stackoverflow issue
#38639266](https://stackoverflow.com/questions/38639266/r-cmd-check-unusual-checking-installed-package-size-note)
this could be due to a RStudio issue and can likely be ignored. However,
I also experimented with different compressions as described in
[CRAN](https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Data-in-packages)
and found "xz" the most efficient, which is what I have used.

### Note 3:

❯ On windows-x86_64-devel (r-devel) checking for detritus in the temp
directory ... NOTE Found the following files/directories:
'lastMiKTeXException'

As noted in [R-hub issue
#503](https://github.com/r-hub/rhub/issues/503), this could be due to a
bug/crash in MiKTeX and can likely be ignored.

### Note 4:

❯ On ubuntu-gcc-release (r-release), fedora-clang-devel (r-devel)
checking examples ... [10s/20s] NOTE Examples with CPU (user + system)
or elapsed time \> 5s user system elapsed wrp_get 7.136 0.663 15.816

According to [Github](https://github.com/microsoft/LightGBM/issues/2988)
this note is allowed.

### Note 5:

❯ On fedora-clang-devel (r-devel) checking CRAN incoming feasibility ...
[6s/23s] NOTE Maintainer: 'David Hammond
[dhammond\@economicsandpeace.org](mailto:dhammond@economicsandpeace.org){.email}'

New submission

Size of tarball: 8806060 bytes

Covered in Note 1 - According to
[Stackoverflow](https://stackoverflow.com/questions/23829978/checking-cran-incoming-feasibility-note-maintainer),
this message can be ignored.

### Note 6:

❯ On fedora-clang-devel (r-devel) checking HTML version of manual ...
NOTE Skipping checking HTML validation: no command 'tidy' found

According to
[Stackoverflow](https://stackoverflow.com/questions/74857062/rhub-cran-check-keeps-giving-html-note-on-fedora-test-no-command-tidy-found)
this note can be ignored.

## Second Submission

### NOTE 1

Found the following (possibly) invalid URLs: URL:
<http://visionofhumanity.org> (moved to
<https://www.visionofhumanity.org/>) From: inst/doc/wrp_vignette.html
Status: 301 Message: Moved Permanently

Please change http --\> https, add trailing slashes, or follow moved
content as appropriate.

-   Fixed

### NOTE 2

Size of tarball: 8807987 bytes

Not more than 5 MB for a CRAN package.

-   Reduced internal data size and fixed, no more NOTE from R CMD check
    or rhub::check_for_cran()

## Third sumbission

Thanks for the quick turnaround! I have amended and R CMD CHECK
completes successfully.

Here is how I have addressed the comments:

### Note 1

If there are references describing the methods in your package, please
add these in the description field of your DESCRIPTION file in the form
authors (year) \<doi:...\> authors (year) \<arXiv:...\> authors (year,
ISBN:...) or if those are not available: \<[https:...]https:...\> with
no space after 'doi:', 'arXiv:', 'https:' and angle brackets for
auto-linking. (If you want to add a title as well please put it in
quotes: "Title")

-   I have amended the DESCRIPTION file, added more context and
    references. I hope I have done this correctly.

### Note 2

A CRAN package should not be larger than 5 MB. Size of tarball: 5108720
bytes Do you think it is possible to reduce the size a bit more? If so,
please do it.

-   I have amended the code so it accesses the large data file online,
    processes it, stores it in the package folder for loading in the
    functions. It also provides a function for the user to delete these
    files if so wished.

### Note 3

Possibly misspelled words in DESCRIPTION: Lloyd's (11:45)

-   This is not a mispelling.

-   Also, running rhub::check_for_cran() regenerates the following NOTES
    that I understand can be ignored for the reasons stated above.

### Note 4

-   checking CRAN incoming feasibility ... NOTE Maintainer: 'David
    Hammond
    [dhammond\@economicsandpeace.org](mailto:dhammond@economicsandpeace.org){.email}'

### Note 5

-   checking examples ... [115s] NOTE Examples with CPU (user + system)
    or elapsed time \> 5s user system elapsed dot-wrp_check 101.85 2.39
    106.27

### Note 6

-   checking for detritus in the temp directory ... NOTE Found the
    following files/directories: 'lastMiKTeXException'

## Submission 4

The third release failed on the following recurring note (with varying
times for the three OS):

Examples with CPU (user + system) or elapsed time \> 10s user system
elapsed dot-wrp_check 126.82 3.14 130.62

-   The reason this NOTE kept on occurring was that the functions
    downloaded AND processed the data in real time. I now have the
    preprocessed and compressed rda data available on Github in the
    package's data-raw folder. I have experimented with compression and
    found 'xz' the most efficient. The package loads this into the
    package environment in the .onLoad() function. I have put 3
    stopifnot() tests into the .onLoad() function. The first checks that
    the computer is connected to the internet. If not, it asks the user
    to re-try when they have a valid internet connection. The second
    checks that the data file is available. If not, there is a message
    to contact the maintainer. The third catches a timeout error and
    informs the user to check their internet connection and try loading
    the package again. I have set the timeout to be 120s.

This significantly reduces processing time and passes the \<5 sec
criteria on windows systems. However, I still get the NOTE on Fedora and
Ubuntu for the function wrp_get(). To address this I have used the
function mclapply instead of base lapply to make use of multicore
processing. While I still still can get the note on Ubuntu and Fedora on
the checks, multicore processing will greatly reduces the processing
time on Ubuntu and Fedora user machines.

I noted above that according to
[Github](https://github.com/microsoft/LightGBM/issues/2988) this note is
allowed. Despite this I have worked to reduce this as much as I can, the
data this package uses is large so aggregating will take some time on
slower machines. The NOTE does not appear when I run it on R CMD check.

## Submission 5

CRAN Reviewers comments:

-   Please omit the qutation marks from your title.

Done.

-   Please make sure that you do not change the user's options, par or
    working directory.

The line `options(2*60)` has been completely removed from .onLoad() in
zzz.R.
