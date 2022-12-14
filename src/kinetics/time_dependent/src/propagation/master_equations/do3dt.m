function all_derivatives_per_m3_s = do3dt(transition_matrix_mod_m3_per_s, decay_coeffs_per_s, equilibrium_constants_m3, all_concs_per_m3, optional)
% Evaluates O3 full concentration derivatives for given concentrations values and transition matrix
% transition_matrix_mod(i, j) has full transition rate constant from j-th to i-th state
% transition_matrix_mod(i, i) has negative sum of full transition rate constants from i-th to all other states
% decay_coeffs and equilibrium_constants have number of columns equal to number of distinct channels in a molecule
% all_concs is a column vector of full concentrations for all states of O3 and reactants
% Total concentrations of reactants are stored in the last 4 elements of all_concs
% in order: reactant 1, 2 of channel 1, then reactant 1, 2 of channel 2
% For 666 only channel 1 exists
  arguments
    transition_matrix_mod_m3_per_s
    decay_coeffs_per_s
    equilibrium_constants_m3
    all_concs_per_m3
    optional.formation_mult = 1
    optional.decay_mult = 1
  end

  o3_per_m3 = all_concs_per_m3(1:size(transition_matrix_mod_m3_per_s, 1));
  reactants_per_m3 = reshape(all_concs_per_m3(size(transition_matrix_mod_m3_per_s, 1)+1 : end), 2, []);
  transition_per_m3_s = transition_matrix_mod_m3_per_s * o3_per_m3;
  formation_per_m3_s = decay_coeffs_per_s .* equilibrium_constants_m3 .* reactants_per_m3(1, :) .* reactants_per_m3(2, :) * optional.formation_mult;
  decay_per_m3_s = decay_coeffs_per_s .* o3_per_m3 * optional.decay_mult;

  derivatives_o3_per_m3_s = transition_per_m3_s + sum(formation_per_m3_s, 2) - sum(decay_per_m3_s, 2);
  derivatives_reactants_per_m3_s = repmat(sum(decay_per_m3_s, 1) - sum(formation_per_m3_s, 1), [2, 1]);
  all_derivatives_per_m3_s = cat(1, derivatives_o3_per_m3_s, derivatives_reactants_per_m3_s(:));
end