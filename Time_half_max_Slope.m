%% Section 1: Read in data
rawdata_dir = 'YOURFILEPATH.csv';
rawdata = readmatrix(rawdata_dir);
time = rawdata(:,1);
rawdata = rawdata(:,2:end);
find_half_max = true; % SET TO false IF YOU WANT TO FIND THE TIME TO HALF MIN
time_interval = 0.5; %Change this to fit time interval (in minutes)

if find_half_max
    [max_values,max_indices] = max(rawdata);
    half_values = ((max_values - 1)/2) + 1;
    %%
    two_point_indices = zeros(2,size(rawdata,2));
    for i_cell = 1:size(rawdata,2)
        if ~isempty(rawdata(:,i_cell)) && ~all(isnan(rawdata(:,i_cell)))
            two_point_indices(1,i_cell) = find(rawdata(:,i_cell)>=half_values(i_cell),1,'first');
            two_point_indices(2,i_cell) = two_point_indices(1,i_cell) - 1;
        end
    end

    slopes = zeros(1,size(rawdata,2));
    slope_at_half_max = zeros(1,size(rawdata,2));
    for i_cell = 1:size(rawdata,2)
        if ~isempty(rawdata(:,i_cell)) && ~all(isnan(rawdata(:,i_cell)))
            slopes(i_cell) = (rawdata(two_point_indices(1,i_cell),i_cell)-rawdata(two_point_indices(2,i_cell),i_cell));
            slope_at_half_max(i_cell) = slopes(i_cell)/time_interval; %Multiply time_interval by 60 if want slope in seconds 
        end
    end

    all_times_to_half_max = zeros(1,size(rawdata,2));
    scaled_all_times_to_half_max = zeros(1,size(rawdata,2));
    for i_cell = 1:size(rawdata,2)
        if ~isempty(rawdata(:,i_cell)) && ~all(isnan(rawdata(:,i_cell)))
            all_times_to_half_max(i_cell) = ((half_values(i_cell)-rawdata(two_point_indices(2,i_cell),i_cell))/slopes(i_cell))+two_point_indices(2,i_cell);
            scaled_all_times_to_half_max(i_cell) = all_times_to_half_max(i_cell)-two_point_indices(2,i_cell);
        end
    end
    %%
    scaled_all_times_to_half_max = scaled_all_times_to_half_max * time_interval;
    for i_cell = 1:size(rawdata,2)
        if ~isempty(rawdata(:,i_cell)) && ~all(isnan(rawdata(:,i_cell)))
            scaled_all_times_to_half_max(i_cell) = scaled_all_times_to_half_max(i_cell)+time(two_point_indices(2,i_cell));
        end
    end
else
    [min_values,min_indices] = min(rawdata);
    half_values = ((1-min_values)/2) + min_values;
    %%
    two_point_indices = zeros(2,size(rawdata,2));
    for i_cell = 1:size(rawdata,2)
        if ~isempty(rawdata(:,i_cell)) && ~all(isnan(rawdata(:,i_cell)))
            two_point_indices(1,i_cell) = find(rawdata(:,i_cell)<=half_values(i_cell),1,'first');
            two_point_indices(2,i_cell) = two_point_indices(1,i_cell) - 1;
        end
    end
    
    slopes = zeros(1,size(rawdata,2));
    for i_cell = 1:size(rawdata,2)
        if ~isempty(rawdata(:,i_cell)) && ~all(isnan(rawdata(:,i_cell)))
            slopes(i_cell) = (rawdata(two_point_indices(1,i_cell),i_cell)-rawdata(two_point_indices(2,i_cell),i_cell));
        end
    end
    
    all_times_to_half_min = zeros(1,size(rawdata,2));
    scaled_all_times_to_half_min = zeros(1,size(rawdata,2));
    for i_cell = 1:size(rawdata,2)
        if ~isempty(rawdata(:,i_cell)) && ~all(isnan(rawdata(:,i_cell)))
            all_times_to_half_min(i_cell) = ((half_values(i_cell)-rawdata(two_point_indices(2,i_cell),i_cell))/slopes(i_cell))+two_point_indices(2,i_cell);
            scaled_all_times_to_half_min(i_cell) = all_times_to_half_min(i_cell)-two_point_indices(2,i_cell);
        end
    end
    %%
    scaled_all_times_to_half_min = scaled_all_times_to_half_min * time_interval;
    for i_cell = 1:size(rawdata,2)
        if ~isempty(rawdata(:,i_cell)) && ~all(isnan(rawdata(:,i_cell)))
            scaled_all_times_to_half_min(i_cell) = scaled_all_times_to_half_min(i_cell)+time(two_point_indices(2,i_cell));
        end
    end
end