function key = get_key(mol, J, K, sym)
% Returns data key corresponding to given molecule, rotational state and symmetry
  key = ['mol_', mol];
  if sym == 0
    key = fullfile(key, 'half_integers');
  end
  key = fullfile(key, ['J_', num2str(J)], ['K_', num2str(K)], 'symmetry_1');
end