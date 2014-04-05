/* ResidualVM - A 3D game interpreter
 *
 * ResidualVM is the legal property of its developers, whose names
 * are too numerous to list here. Please refer to the COPYRIGHT
 * file distributed with this source distribution.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.

 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 *
 */

#include <stdio.h>
#include <string.h>
#include <stdint.h>

// The movies included with EMI have a SMUSH header, but will play fine in
// mplayer without it. This simple utility just takes off the header.

#define BUF_SZ 0x2000
int main(int argc, char **argv) {
	FILE *rfd, *wfd;
	uint32_t consumed = 0;
	uint32_t i = 0;
	unsigned char buf[BUF_SZ];
	uint32_t bik_start = 0;

	if (argc != 3) {
		printf("Usage:\n\tfix_bik <Movie File> <Output File>\n");
		return -1;
	}

	// Clear the buffer memory
	memset(buf, 0, BUF_SZ);

	// Open the files
	rfd = fopen(argv[1], "r");
	if (!rfd) {
		printf("Unable to open the movie file: %s\n", argv[1]);
		return -1;
	}
	wfd = fopen(argv[2], "w");
	if (!rfd) {
		printf("Unable to open the output file for writing: %s\n", argv[2]);
		return -1;
	}

	// Read the first 5 bytes of the header
	fread(buf, 5, 1, rfd);
	buf[5] = 0;

	// If the first 5 bytes are SMUSH, find the start of the BIK header
	if (!strncmp((const char *)buf, "SMUSH", 5)) {
		fread(buf, 16, 1, rfd);
		consumed += 16;

		// Decode the first part
		for (i=0; i<consumed; i++) {
			buf[i] ^= 0xd2;
		}

		// Get the SMUSH Header Length
		sscanf((const char *)buf, "%u", &bik_start);

		if (bik_start > BUF_SZ) {
			printf("SMUSH Header doesn't make sense, refusing to go further\n");
			return -1;
		}
	}

	// Seek to the start of the BIK movie
	fseek(rfd, bik_start, SEEK_SET);

	// Read the BIK header
	fread(buf, 3, 1, rfd);
	buf[3] = 0;

	// Sanity check to make sure we found the movie data
	if (!strncmp((const char *)buf, "BIK", 3)) {
		fseek(rfd, -3, SEEK_CUR);
	} else {
		printf("No BIK header found, possibly not a BINK file?\n");
	}

	// Read the BIK into the output file
	while (!feof(rfd)) {
		fread(buf, BUF_SZ, 1, rfd);
		fwrite(buf, BUF_SZ, 1, wfd);
	}

	fclose(rfd);
	fclose(wfd);
	return 0;
}
