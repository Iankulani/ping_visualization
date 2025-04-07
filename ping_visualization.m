% Cybersecurity Tool: Ping IP Address and Visualize Traffic

% Prompt the user to enter an IP address
ip_address = input('Enter the IP address to ping: ', 's');

% Number of pings to send
num_pings = 10;

% Initialize array to store the response times
response_times = NaN(1, num_pings);

% Ping the IP address and capture the output
for i = 1:num_pings
    % Run the ping command
    [status, cmdout] = system(['ping -n 1 ' ip_address]);
    
    % If the ping was successful, extract the time
    if status == 0
        % Extract the time from the output string
        expression = 'time=(\d+)ms';
        tokens = regexp(cmdout, expression, 'tokens');
        
        if ~isempty(tokens)
            % Store the response time
            response_times(i) = str2double(tokens{1}{1});
        else
            % If there's no response time, set to NaN (timeout)
            response_times(i) = NaN;
        end
    else
        % If the ping fails, set the response time to NaN
        response_times(i) = NaN;
    end
    
    % Pause for 1 second between pings
    pause(1);
end

% Display the results
fprintf('\nPing results for IP address: %s\n', ip_address);
fprintf('Response times (ms):\n');
disp(response_times);

% Visualize the traffic (Ping Latency) over time
figure;
plot(1:num_pings, response_times, '-o', 'LineWidth', 2, 'MarkerSize', 6);
xlabel('Ping Attempt');
ylabel('Response Time (ms)');
title(['Ping Latency to ' ip_address]);
grid on;

% Display if there were any packet losses
loss_percentage = sum(isnan(response_times)) / num_pings * 100;
fprintf('Packet loss: %.2f%%\n', loss_percentage);
