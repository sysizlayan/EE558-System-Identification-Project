%%MAP Estimate

sum_error = 1e40;
best_n_pole_MAP=0;
best_n_zero_MAP=0;
for n_pole = 1:5
    for n_zero= 1:n_pole
        num_MAP = [];
        denum_MAP = [];
        errors_MAP = [];
        for i=1:17
            [tmp_num, tmp_denum] = MLHEstimate(y_vec(:,i),u_vec(:,i),n_pole,n_zero, sigma);
            y_hat = filter(tmp_num,tmp_denum,u_vec(:,i));
            
            error_i = sum(y_vec(:,i)-y_hat);
            errors_MAP = [errors_MAP;error_i];
            num_MAP = [num_MAP;tmp_num];
            denum_MAP = [denum_MAP;tmp_denum];
        end
        
        if(sum_error>sum(errors_MAP))
            sum_error=sum(errors_MAP);
            display(sum_error,'Best Sum of errors')
            best_n_pole_MAP = n_pole;
            best_n_zero_MAP = n_zero;
        end
    end
end
num_MAP = [];
denum_MAP = [];
errors_MAP = [];
for i=1:17
    [tmp_num, tmp_denum] = MLHEstimate(y_vec(:,i),u_vec(:,i),best_n_pole_MAP,best_n_zero_MAP, sigma);
    y_hat = filter(tmp_num,tmp_denum,u_vec(:,i));

    error_i = sum(y_vec(:,i)-y_hat);
    errors_MAP = [errors_MAP;error_i];
    num_MAP = [num_MAP;tmp_num];
    denum_MAP = [denum_MAP;tmp_denum];
end