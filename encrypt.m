function outputStr = encrypt(inputStr, multKey, addKey)
%ENCRYPT Encrypt a message using an affine cipher
%   outputStr = encrypt(inputStr, multKey, addKey)
%   inputStr message before encryption
%   multKey multiplicative cipher key (int, should be relatively prime to 26)
%           1, 3, 5, 7, 9, 11, 15, 17, 19, 21, 23, 25
%   addKey additive cipher key (can be any integer)

% standardize input to char array
if isa(inputStr, 'string')
    inputStr = inputStr{1};
end

multKey = uint32(multKey);
addKey = uint32(addKey);
inputStr = upper(inputStr);
outputStr = inputStr;

for i = 1:length(inputStr)
    outputStr(i) = enc_letter(inputStr(i), multKey, addKey);
end

function e = enc_letter(c, m, a)
% encrypt a sinlge letter if alphabetical
% assumes letters are capitalized
% if nonalpha, return c

if ~isletter(c)
    e = c;
else
    x = uint32(c) - 65;
    x = mod((x * m) + a, 26);
    e = char(x + 65);
end