## Test environments
- R-hub windows-x86_64-devel (r-devel)
- R-hub ubuntu-gcc-release (r-release)
- R-hub fedora-clang-devel (r-devel)

## R CMD check results
❯ On windows-x86_64-devel (r-devel), ubuntu-gcc-release (r-release)
  checking CRAN incoming feasibility ... NOTE
  Maintainer: 'The package maintainer <dhammond@economicsandpeace.org>'
  
  New submission
  
  Author field should be Authors@R.  Current value is:
    person("David", "Hammond", email = "dhammond@economicsandpeace.org", role = c("aut", "cre"))
  
  The Title field should be in title case. Current version is:
  'Individual-level survey data from the World Risk Poll'
  In title case that is:
  'Individual-Level Survey Data from the World Risk Poll'
  
  DESCRIPTION fields with placeholder content:
    Maintainer: The package maintainer <dhammond@economicsandpeace.org>
  
  Size of tarball: 8985235 bytes

❯ On windows-x86_64-devel (r-devel), ubuntu-gcc-release (r-release), fedora-clang-devel (r-devel)
  checking installed package size ... NOTE
    installed size is  8.7Mb
    sub-directories of 1Mb or more:
      R   8.4Mb

❯ On windows-x86_64-devel (r-devel)
  checking sizes of PDF files under 'inst/doc' ... NOTE
  Unable to find GhostScript executable to run checks on size reduction

❯ On windows-x86_64-devel (r-devel)
  checking for detritus in the temp directory ... NOTE
  Found the following files/directories:
    'lastMiKTeXException'

❯ On ubuntu-gcc-release (r-release)
  checking examples ... [10s/19s] NOTE
  Examples with CPU (user + system) or elapsed time > 5s
           user system elapsed
  wrp_get 7.054  0.616  14.735

❯ On fedora-clang-devel (r-devel)
  checking CRAN incoming feasibility ... [6s/17s] NOTE
  Maintainer: ‘The package maintainer <dhammond@economicsandpeace.org>’
  
  New submission
  
  Author field should be Authors@R.  Current value is:
    person("David", "Hammond", email = "dhammond@economicsandpeace.org", role = c("aut", "cre"))
  
  The Title field should be in title case. Current version is:
  ‘Individual-level survey data from the World Risk Poll’
  In title case that is:
  ‘Individual-Level Survey Data from the World Risk Poll’
  
  DESCRIPTION fields with placeholder content:
    Maintainer: The package maintainer <dhammond@economicsandpeace.org>
  
  Size of tarball: 8985235 bytes

❯ On fedora-clang-devel (r-devel)
  checking examples ... [10s/20s] NOTE
  Examples with CPU (user + system) or elapsed time > 5s
           user system elapsed
  wrp_get 6.983  0.674  15.427

❯ On fedora-clang-devel (r-devel)
  checking HTML version of manual ... NOTE
  Skipping checking HTML validation: no command 'tidy' found

0 errors ✔ | 0 warnings ✔ | 8 notes ✖
