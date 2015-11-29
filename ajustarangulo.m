%%%% método dos mínimos quadrados MMQ %%%%%%
function jogo

% variaveis uteis
quitGame = false;
theta = [];
x=[0];
y=[0];
click_x=[];
click_y=[];

function pega_pontos
	axis([0 10 0 10]);
	[click_x, click_y] = ginput(1);
end

function add_pontos
	x = [ x; click_x];
	y = [ y; click_y];
end

%%% ajustar uma reta pelo MMQ
function plota
	A=[ones(size(x)) x]; % só 1 na primeira coluna

	c=A\y; % solução de Ac=y representa reta ya_j=c_1+c_2 x_j
	ya= c(1)+c(2)*x;
	plot(x,y,'r*', x,ya,'b');
	axis([0 10 0 10]);

	% calcular angulo
	theta = radtodeg(atan(c(2)))
	%theta = atan2(norm(cross(d,f)), dot(d,f))

	% calcular resíduo
	yaux=A*c;
	res=y-yaux;
	ResiduoMMQ=res'*res; % res transposto * res
end

while ~quitGame
	pega_pontos;
	add_pontos;
	plota;
end

end