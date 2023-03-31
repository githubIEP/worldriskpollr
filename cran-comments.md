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

-   Examples with CPU (user + system) or elapsed time \> 10s user system
    elapsed dot-wrp_check 126.82 3.14 130.62

The reason this NOTE kept on occurring was that the functions downloaded
AND processed the data in real time. I now have the preprocessed and
compressed rda data available on Github in the package's data-raw
folder. I have experimented with compression and found 'xz' the most
efficient. The package loads this into the package environment in the
.onLoad() function. I have put 3 stopifnot() tests into the .onLoad()
function. The first checks that the computer is connected to the
internet. If not, it asks the user to re-try when they have a valid
internet connection. The second checks that the data file is available.
If not, there is a message to contact the maintainer. The third catches
a timeout error and informs the user to check their internet connection
and try loading the package again.

This significantly reduces processing time and passes the \<5 sec
criteria on windows systems.

However, I still get the NOTE on Fedora and Ubuntu for the function
wrp_get(). To address this I have used the function mclapply instead of
base lapply to make use of multicore processing. This assigns 1 core on
windows machines, and the minimum of 2 cores ([CRAN
limit](https://stackoverflow.com/questions/50571325/r-cran-check-fail-when-using-parallel-functions))
or detectCores() (to account for machines that don't have 2 cores) on
other OS's.

Unfortunately this did not change the processing times in the NOTE for
Ubuntu of Fedora. However, multicore processing will greatly reduces the
processing time on Ubuntu and Fedora user machines.

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

The line `options(timeout = 2*60)` has been completely removed from
.onLoad() in zzz.R.

## Submission 6

Upon release on CRAN, I noticed the pdf manual on CRAN had documentation
of non-exported functions. I have added @noRd to the roxygen notes of
each to remove these from the pdf.

## Submission 7

-   My submission 6 was blocked because it was too soon after release,
    which was fine because the changes were aesthetic only.

-   For submission 7 though, I have added new functionality that allows
    for world aggregation as per a user request. So this submission has
    the aesthetic submission from No. 6 and additional functionality. I
    have added testthat tests to check this new functionality and these
    all pass on R CMD check.

-   On rhub::check_for_cran() the package receives the same notes on
    timing from Ubuntu and Fedora as it did before.

-   I also noticed the following NOTE from the CRAN results page
    [r-oldrel-windows-ix86+x86_64](https://cran.r-project.org/web/checks/check_results_worldriskpollr.html)

Check: R code for possible problems Result: NOTE Initiating curl with
CURL_SSL_BACKEND: openssl Flavor: r-oldrel-windows-ix86+x86_64

-   I googled this and can not find a solution. I also saw this note on
    other CRAN packages, so I am assuming this can be ignored.

Thanks again or your diligence.


## Submission 8

-   Added new functionality that allows user to select disaggregation. This was a user request. 

-   Adding this significantly improves processing time, from 12 sec (in the worst case) to consistently less than 1 sec. As a result, I no longer get the notes from rhub::check_for_cran() of "greater than 5 sec".

-   Improved the documentation of wrp_get with a @details section.

-   I have added testthat tests to check this new functionality and these
    all pass on R CMD check.
    
-   Also, implemented cleaner error handling to avoid stopifnot error breaks.

-   On rhub::check_for_cran() this also solves the greater than 5 sec errors on all checks.


