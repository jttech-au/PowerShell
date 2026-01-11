$7zipArgs = @(
    "a";                          # Create an archive.
    "-t7z";                       # Use the 7z format.
    "-mx=7";                      # Use a level 7 "high" compression.
    "-xr!thumbs.db";              # Exclude thumbs.db files wherever they are found.
    "-xr!*.log";                  # Exclude all *.log files as well.
    "-xr-@`"`"$excludesFile`"`""; # Exclude all paths in my excludes.txt file.
    "-ir-@`"`"$includesFile`"`""; # Include all paths in my includes.txt file.
    "$outputFile";                # Output file path (a *.7z file).
)

$7zipArgs = @(
    "u";                                    # Update an archive. Slightly confusing since we'll be saving those updates to a new archive file.
    "$fullBackupPath";                      # Path of the full backup we are creating a differential for.
    "-t7z";
    "-mx=7";
    "-xr!thumbs.db";
    "-xr!*.log";
    "-xr-@`"`"$excludesFile`"`"";
    "-ir-@`"`"$includesFile`"`"";
    "-u-";                                  # Don't update the original archive (the full backup).
    "-up0q3r2x2y2z0w2!`"`"$outputFile`"`""; # Flags to specify how the archive should be updated and the output file path (a *.7z file).
)