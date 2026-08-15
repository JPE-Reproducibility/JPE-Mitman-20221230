function [SaveDir,CodeDir] = getDirs()
    
    user = getenv('USER');
    if isempty(user)
        user = getenv('USERNAME');
    end

    if strcmpi(user, 'kmitm')
        SaveDir = '~/Dropbox/';
        CodeDir = '~/GitHub/BKKS/';
    elseif strcmpi(user, 'tobiasbroer')
        SaveDir='/Users/tobiasbroer/Dropbox/Research/Current_Projects/';
        CodeDir='/Users/tobiasbroer/GutHub/BKKS/';
    else
        % tobi, but yours here
    end
end
