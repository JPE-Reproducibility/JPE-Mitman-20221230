function id = idx(i,j,npk)
    % i : 1..npk   (mean index)
    % j : 1..nsigK   (variance index)
    % k : 1..npzp   (posterior belief index)
    % id = i + npk .* (j-1 + nsigK .* (k-1));
    id = i + npk .* (j-1);
end
