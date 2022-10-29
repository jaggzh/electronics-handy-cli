# electronics-handy-cli

Electronics references and utilities; maybe handy for some.

By jaggz.h who is at gmail

# Examples:

* resistor-color-codes
![Screenshot: Resistor color codes](i/ss--resistor-color-codes.png "Screenshot of resistor-color-codes command output")
* electronics-example-debounce-button-switch
![Screenshot: Debounce example](i/ss--electronics-example-debounce-button-switch.png "Screenshot of debounce text schematic output")
* electronics-led-r-and-w
![Screenshot: LED/Diode Resistor/Power Calculation](i/ss--electronics-led-r-and-w.png "Screenshot of LED/Diode Resistor calculator")

# Installation / Requirements

1. Perl needs to be installed for some utils
1. With Perl, some use Text::Table, or other perl module dependencies you may need to install (on Debian based systems, eg., `apt install libtext-table-perl` or `cpanm Text::Table` or ...)
1. I check out the repository, then symlink the utils I want into my ~/bin/ folder (ie. `cd ~/bin && ln -s ~/local/src/electronics-handy-cli/resistor-color-codes` etc.)
