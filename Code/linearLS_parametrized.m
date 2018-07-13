%%Linear Least Squares

sum_error = 1e40;
best_n_pole_linearLS=0;
best_n_zero_linearLS=0;
for n_pole = 1:17
    for n_zero= 1:n_pole
        num_linearLS = [];
        denum_linearLS = [];
        errors_linearLS = [];
        for i=1:17
            [tmp_num, tmp_denum] = linearLS(y_vec(:,i),u_vec(:,i),n_pole,n_zero);
            y_hat = filter(tmp_num,tmp_denum,u_vec(:,i));
            
            error_i = sum(y_vec(:,i)-y_hat);
            errors_linearLS = [errors_linearLS;error_i];
            num_linearLS = [num_linearLS;tmp_num];
            denum_linearLS = [denum_linearLS;tmp_denum];
        end
        
        if(sum_error>sum(errors_linearLS))
            sum_error=sum(errors_linearLS);
            display(sum_error,'Best Sum of errors')
            best_n_pole_linearLS = n_pole;
            best_n_zero_linearLS = n_zero;
        end
    end
end
num_linearLS = [];
denum_linearLS = [];
errors_linearLS = [];
for i=1:17
    [tmp_num, tmp_denum] = linearLS(y_vec(:,i),u_vec(:,i),best_n_pole_linearLS,best_n_zero_linearLS);
    y_hat = filter(tmp_num,tmp_denum,u_vec(:,i));

    error_i = sum(y_vec(:,i)-y_hat);
    errors_linearLS = [errors_linearLS;error_i];
    num_linearLS = [num_linearLS;tmp_num];
    denum_linearLS = [denum_linearLS;tmp_denum];
end