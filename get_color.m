function value = get_color(color)
    switch color
        case 'r'
            value = [255, 0, 0];
        case 'g'
            value = [0, 255, 0];
        case 'b'
            value = [0, 0, 255];
        case 'y'
            value = [255, 255, 0];
        otherwise
            error('Undefined color: %s\n', color)
    end
    value = reshape(value, 1, 1, 3);
end