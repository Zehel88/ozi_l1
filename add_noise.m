function S=add_noise(S,n)
for i=1:n
    x=randi(numel(S));
    S(x)=num2str(~str2double(S(x)));
    
end
