# To use this function on the command line, put the following lines in your ".bashrc" file.

# Function to check if two files are identical, based on their SHA-256 checksums
function equal {
	local hash1=$(sha256sum "$1" | cut -d  ' ' -f 1)
	local hash2=$(sha256sum "$2" | cut -d  ' ' -f 1)
	[ $hash1 == $hash2 ] && echo "Files are EQUAL." || echo "Files are DIFFERENT."
}

# Function to check if two strings are identical
function strequal {
	local hash1="$1"
	local hash2="$2"
	[ $hash1 == $hash2 ] && echo "Strings are EQUAL." || echo "Strings are DIFFERENT."
}
