function [ num, denum] = MLHEstimate(output,input,n_pole,n_zero, sigma  )
    if(n_zero > n_pole)
        display('ERROR, number of zeros cannot be greater than poles')
    else
        phi = zeros(length(output)-n_pole, n_pole+n_zero);
        for i= 1:length(output)-n_pole
            for j=1:n_pole
                phi(i, j) = output(end-1-i-j+2);
            end
            for j=1:n_zero
                phi(i,n_pole+j) = input(end-1-i-j+2);
            end
        end
        phi = flipud(phi);
        output = output(n_pole+1:end);
    
        tmpSigma=sigma;

        if sigma==0
            disp('Sigma is zero, in order to prevent singularity it is made 1e-6');
            tmpSigma = 1e-6;
        end

        identificationConstants = (phi'* tmpSigma^-1 *phi + 1e-6*eye(n_pole+n_zero))\(phi'*tmpSigma^-1*output);

        denum = [1;-1*identificationConstants(1:n_pole)]';
        num = identificationConstants(n_pole+1:end)';
    end
end

