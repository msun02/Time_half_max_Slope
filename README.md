# Time_half_max_Slope
# Linear interpolation of signal transitions using Time_half_max_Slope

*Danielle Schmitt Lab, Department of Chemistry and Biochemistry, UC Los Angeles*

*Last updated: 9 January 2026*

 
## Contents
1.	System Requirements
2.	Installation Guide
3.	Instructions for Use and Demo

### System Requirements
The program has been tested using the following operating systems:
- Mac OS Ventura 13.6.4 64-bit
- MATLAB versions R2024b
- MATLAB toolboxes required to run every component of the packaged software:
  - Statistics and Machine Learning

### Installation Guide
1.	Download the Seg_GUI_Ratio analysis software package from [Github](https://github.com/msun02/Time_half_max_Slope)
2.	Extract zip file
3.	Open MATLAB
4.	Navigate to the unzipped Time_half_max_Slope-main folder in MATLAB's "Current Folder" window
5.	Right-click on the Time_half_max_Slope-main folder and select "Add to Path" -> "Selected Folders and Subfolders"

### Instructions for use 
- Preparing Data
  - The script requires a .csv file with the following structure:
    - Format: Numeric data only; headers should be removed or handled via the readmatrix offset. 
    - Column 1: Time points.
    - Columns 2+: Individual experimental traces (e.g., Cell 1, Cell 2, etc.).
- Configuration
  - Before running, open the script and modify Section 1 with specific parameters:
    - rawdata_dir: Enter the full path to your .csv file.
    - find_half_max:
      - Set to true to find time to half-maximum.
      - Set to false to find time to half-minimum.
    - time_interval: Enter the sampling rate in minutes (e.g., 0.5).
- Execution
  - 1\. Ensure the parameters are saved.
  - 2\. Click Run.
  - 3\. The script will perform linear interpolation between discrete time points to find the exact moment the signal crosses the 50% threshold.
- Output Data
  - Upon completion, the script populates the MATLAB Workspace with the following results:
    - scaled_all_times_to_half_max: The interpolated time (in minutes) where each cell reached the half-max.
    - scaled_all_times_to_half_min: The interpolated time (in minutes) where each cell reached the half-min.
    - slope_at_half_max: The calculated rate of change ($Δy/Δt$) at the moment of transition.
- Reference Values
  - max_values or min_values: The detected peaks or troughs for each trace.
  - half_values: The calculated target $y$-value (midpoint) used for interpolation.
  - two_point_indices: The indices of the two data points flanking the half-value.
