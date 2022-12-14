function plot_krec_vs_pressure_experimental_666()
% Plots experimental data of krec (in m6/s) dependency on pressure (in bar) for 666 
% Does not create new plot
  data = get_krec_vs_pressure_experimental_666();
  plot(data(:, 1), data(:, 2), 'k.', 'MarkerSize', 20);
end