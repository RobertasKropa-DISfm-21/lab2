clear all
close all

%% 1 - duomenų ruošimas
x=[0.1:1/22:1];
d=(1 + 0.6*sin(2*pi*x/0.7) + 0.3*sin(2*pi*x))./2;

plot(x, d, 'b*'), grid on

%% 2 - tiklo struktūra ir svoriai

%paslepto sluoksnio ryšių svoriai
w11_1 = randn(1);
w21_1 = randn(1);
w31_1 = randn(1);
w41_1 = randn(1);
w51_1 = randn(1);

%išėjimo ryšių svoriai
b1_1 = randn(1);
b2_1 = randn(1);
b3_1 = randn(1);
b4_1 = randn(1);
b5_1 = randn(1);

%išėjimo sluoksnios voriai
w11_2 = randn(1);
w12_2 = randn(1);
w13_2 = randn(1);
w14_2 = randn(1);
w15_2 = randn(1);

%ryšių svoriai
b1_2 = randn(1);
%% 3
n=0.1
for temp = 1:100000
    for i=1:length(x)
        %tinklo atsakas
        v1_1 = x(i) * w11_1 + b1_1;
        v2_1 = x(i) * w21_1 + b2_1;
        v3_1 = x(i) * w31_1 + b3_1;
        v4_1 = x(i) * w41_1 + b4_1;
        v5_1 = x(i) * w51_1 + b5_1;
% 
%         v1_2 = x(i) * w11_2 + b1_2;
%         v2_2 = x(i) * w21_2 + b2_2;
%         v3_2 = x(i) * w31_2 + b3_1;
%         v4_2 = x(i) * w41_2 + b4_1;
%         v5_2 = x(i) * w51_2 + b5_1;

        %taikoma aktyvavimo funkcija
        y1_1 = 1 / (1 + exp(-v1_1));
        y2_1 = 1 / (1 + exp(-v2_1));
        y3_1 = 1 / (1 + exp(-v3_1));
        y4_1 = 1 / (1 + exp(-v4_1));
        y5_1 = 1 / (1 + exp(-v5_1));
        v1_2 = y1_1 * w11_2 + y2_1 * w12_2+ y3_1 * w13_2 + y4_1 * w14_2 + y5_1 * w15_2 + b1_2;
        y = v1_2;
        %klaidos skačiavimas
        e = d(i) - y;

        %svorių atnaujinimas
        delta1_2 = 1 * e;

        delta1_1 = (y1_1 * (1 - y1_1)) * delta1_2 * w11_2;
        delta2_1 = (y2_1 * (1 - y2_1)) * delta1_2 * w12_2;
        delta3_1 = (y3_1 * (1 - y3_1)) * delta1_2 * w13_2;
        delta4_1 = (y4_1 * (1 - y4_1)) * delta1_2 * w14_2;
        delta5_1 = (y5_1 * (1 - y5_1)) * delta1_2 * w15_2;

        %atnaujiname išėjimo svorius
        w11_2 = w11_2 + n * delta1_2 * y1_1;
        w12_2 = w12_2 + n * delta1_2 * y2_1;
        w13_2 = w13_2 + n * delta1_2 * y3_1;
        w14_2 = w14_2 + n * delta1_2 * y4_1;
        w15_2 = w15_2 + n * delta1_2 * y5_1;

        b1_2 = b1_2 + n * delta1_2;

        %atnaujiname paslėpto sluoksnio svorius
        w11_1 = w11_1 + n * delta1_1 * x(i);
        w21_1 = w21_1 + n * delta2_1 * x(i);
        w31_1 = w31_1 + n * delta3_1 * x(i);
        w41_1 = w41_1 + n * delta4_1 * x(i);
        w51_1 = w51_1 + n * delta5_1 * x(i);

        b1_1 = b1_1 + n * delta1_1;
        b2_1 = b2_1 + n * delta2_1;
        b3_1 = b3_1 + n * delta3_1;
        b4_1 = b4_1 + n * delta4_1;
        b5_1 = b5_1 + n * delta5_1;
    end
end

Y = zeros(1, length(x))

for i=1:length(x)
        v1_1 = x(i) * w11_1 + b1_1;
        v2_1 = x(i) * w21_1 + b2_1;
        v3_1 = x(i) * w31_1 + b3_1;
        v4_1 = x(i) * w41_1 + b4_1;
        v5_1 = x(i) * w51_1 + b5_1;

        %taikoma aktyvavimo funkcija
        y1_1 = 1 / (1 + exp(-v1_1));
        y2_1 = 1 / (1 + exp(-v2_1));
        y3_1 = 1 / (1 + exp(-v3_1));
        y4_1 = 1 / (1 + exp(-v4_1));
        y5_1 = 1 / (1 + exp(-v5_1));
        y = y1_1 * w11_2 + y2_1 * w12_2+ y3_1 * w13_2 + y4_1 * w14_2 + y5_1 * w15_2 + b1_2;
        Y(i) = y;
end
hold on, plot(x,Y,'g+'), hold off





















