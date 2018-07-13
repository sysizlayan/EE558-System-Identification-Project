initialization

%%DIFFERENT SYSTEM IDS FOR EACH PATCH
%I have applied different system identification methods for each small
%region. The resulting models will be used for parametrized system
%identification.
linearLS_parametrized
MLHEstimate_parametrized
MAPEstimate_parametrized

clear tmp_denum tmp_num i n_pole n_zero sum_error error_i

fitOrder=3;

inputsForCurveFitting = u_vec(1,:)';
fit_func_numLS_forward = fit(inputsForCurveFitting(1:2:17),num_linearLS(1:2:17),strcat('poly',num2str(fitOrder)));
fit_func_numLS_backward = fit(inputsForCurveFitting(2:2:16),num_linearLS(2:2:16),strcat('poly',num2str(fitOrder)));

% fit_func_numMAP= fit(inputsForCurveFitting,num_MAP,strcat('poly',num2str(fitOrder)));
% fit_func_numMLH= fit(inputsForCurveFitting,num_MLH,strcat('poly',num2str(fitOrder)));
coeffvals_numLS_forward = coeffvalues(fit_func_numLS_forward);
coeffvals_numLS_backward = coeffvalues(fit_func_numLS_backward);


fig1 = figure;
h=gcf;
set(h,'PaperOrientation','landscape');
set(h,'PaperPosition', [1 1 28 19]);

subplot(1,2,2)
plot(fit_func_numLS_forward,inputsForCurveFitting(1:2:17),num_linearLS(1:2:17),'o')
xlabel('Speed Input(\mus)')
title('Numerator Consts. Func. wrt Input for Forward')
xlim([40,460])
subplot(1,2,1)
plot(fit_func_numLS_backward,inputsForCurveFitting(2:2:16),num_linearLS(2:2:16),'o')
xlabel('Speed Input(\mus)')
title('Numerator Consts. Func. wrt Input for Backward')
xlim([-410,-40])
print(h,'num_1','-dpng')
print(h,'num_1','-dpdf')
coeffvals_denumLS_forward =[];
coeffvals_denumLS_backward = [];
for i=2:6
    fit_forward = fit(inputsForCurveFitting(1:2:17),denum_linearLS(1:2:17,i),strcat('poly',num2str(fitOrder)));
    fit_backward = fit(inputsForCurveFitting(2:2:16),denum_linearLS(2:2:16,i),strcat('poly',num2str(fitOrder)));
    
    fig = figure;
    h=gcf;
    set(h,'PaperOrientation','landscape');
    set(h,'PaperPosition', [1 1 28 19]);

    subplot(1,2,2)
    plot(fit_forward,inputsForCurveFitting(1:2:17),denum_linearLS(1:2:17,i),'o')
    xlabel('Speed Input(\mus)')
    title(strcat('Denominator Const. Func. #',num2str(i),' wrt Input for Forward'))
    xlim([40,460])
    subplot(1,2,1)
    plot(fit_backward,inputsForCurveFitting(2:2:16),denum_linearLS(2:2:16,i),'o')
    xlabel('Speed Input(\mus)')
    title(strcat('Denominator Const. Func. #',num2str(i),' wrt Input for Backward'))
    xlim([-410,-40])
    coeffvals_denumLS_forward = [coeffvals_denumLS_forward;coeffvalues(fit_forward)];
    coeffvals_denumLS_backward = [coeffvals_denumLS_backward;coeffvalues(fit_backward)];
    print(h,strcat('denum_',num2str(i)),'-dpng')
    print(h,strcat('denum_',num2str(i)),'-dpdf')
end