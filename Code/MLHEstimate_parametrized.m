%%MLH Estimate

sum_error = 1e40;
best_n_pole_MLH=0;
best_n_zero_MLH=0;

for n_pole = 1:5
    for n_zero= 1:n_pole
        num_MLH = [];
        denum_MLH = [];
        errors_MLH = [];
        for i=1:17
            [tmp_num, tmp_denum] = MLHEstimate(y_vec(:,i),u_vec(:,i),n_pole,n_zero, sigma);
            y_hat = filter(tmp_num,tmp_denum,u_vec(:,i));
            
            error_i = sum(y_vec(:,i)-y_hat);
            errors_MLH = [errors_MLH;error_i];
            num_MLH = [num_MLH;tmp_num];
            denum_MLH = [denum_MLH;tmp_denum];
        end
        
        if(sum_error>sum(errors_MLH))
            sum_error=sum(errors_MLH);
            display(sum_error,'Best Sum of errors')
            best_n_pole_MLH = n_pole;
            best_n_zero_MLH = n_zero;
        end
    end
end
num_MLH = [];
denum_MLH = [];
errors_MLH = [];
for i=1:17
    [tmp_num, tmp_denum] = MLHEstimate(y_vec(:,i),u_vec(:,i),best_n_pole_MLH,best_n_zero_MLH, sigma);
    y_hat = filter(tmp_num,tmp_denum,u_vec(:,i));

    error_i = sum(y_vec(:,i)-y_hat);
    errors_MLH = [errors_MLH;error_i];
    num_MLH = [num_MLH;tmp_num];
    denum_MLH = [denum_MLH;tmp_denum];
end