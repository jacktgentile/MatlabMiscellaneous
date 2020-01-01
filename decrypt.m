function outputStr = decrypt(inputStr, multKey, addKey)
%DECRYPT Decrypt a message using an affine cipher
%   outputStr = decrypt(inputStr, multKey, addKey)
%   inputStr message before decryption
%   multKey multiplicative cipher key (int that is relatively prime to 26)
%           1, 3, 5, 7, 9, 11, 15, 17, 19, 21, 23, 25
%   addKey additive cipher key (can be any positive integer)

% standardize input to char array
if isa(inputStr, 'string')
    inputStr = inputStr{1};
end

multKey = uint32(multKey);
addKey = uint32(addKey);

invList = [1,0,9,0,21,0,15,0,3,0,19,0,0,0,7,0,23,0,11,0,5,0,17,0,25];
multInv = invList(multKey);
addInv = 26 - addKey;

inputStr = upper(inputStr);
outputStr = inputStr;

for i = 1:length(inputStr)
    % decryption is encryption with inverses, adding before multiplying
    outputStr(i) = dec_letter(inputStr(i), multInv, addInv);
end

function e = dec_letter(c, m, a)
% decrypt a sinlge letter if alphabetical
% assumes letters are capitalized
% if nonalpha, return c

if ~isletter(c)
    e = c;
else
    x = uint32(c) - 65;
    x = mod((x + a) * m, 26);
    e = char(x + 65);
end