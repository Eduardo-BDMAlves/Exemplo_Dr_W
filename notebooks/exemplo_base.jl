### A Pluto.jl notebook ###
# v0.14.3

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 65bad610-a606-11eb-1058-016b40953c55
begin
	using DrWatson
	using DifferentialEquations
	using Plots
	# plotlyjs()
	using PlutoUI
	using Measurements
	using ImageShow
	using PNGFiles
	using ImageIO
	gr()
end;

# ╔═╡ 85b9ab0e-eb1d-47ed-956d-39dea6a46fbc
TableOfContents(title="Sumário",aside=true)

# ╔═╡ 8cf10a61-6e4a-4906-92a0-3d79105821cb
html"<button onclick='present()'>present</button>"

# ╔═╡ c90b1f2a-c307-422d-9012-d81626c8371f
md"""
# Exemplo de notebook iterativo
"""

# ╔═╡ a12e82cb-b32b-4220-bf6e-e16a9cf2ccdd
md"""
Esse notebook é um exemplo simples de como implementar um notebook interativo que pode ser usado para ensinar tópicos diversos. De um modo geral ele combina a versatilidade de poder escrever equações e deduções completas de modelos, bem como ser usado para rodar códigos e apresentação de resultados.
"""

# ╔═╡ e03e002b-2cb3-43f8-a3bc-7511d8c610e6
md"""
## Adição de mídia

Outra funcionalidade muito importante do **notebook** é a capacidade de lidar com tano vídeos, links e imagens sem grandes problemas. Muitas dessas funções estarão associadas à linguagem júlia e serão apresentadas a seguir, contudo um exemplo muito útil, como o de adicionar vídeos pode ser demosntrado por:
"""

# ╔═╡ d2d3386c-5bb6-4b25-aaab-66dd332434b0
html"""
<p style="
font-size: 1.5rem;
text-align: center;
opacity: .8;
"><em>Aula 1</em></p>
<div style="display: flex; justify-content: center;">
<div  notthestyle="position: relative; right: 0; top: 0; z-index: 300;">
<iframe src="https://www.youtube.com/embed/R0QtTarMu0Y" width=400 height=250  frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></div>
</div>
</div>
"""

# ╔═╡ 124e4008-bc25-4b70-86bd-680b18cf5c4e
philip_link= "https://user-images.githubusercontent.com/6933510/107239146-dcc3fd00-6a28-11eb-8c7b-41aaf6618935.png";

# ╔═╡ a62a2989-dc16-49b8-888f-6ce958e84f31
philip_img_f=download(philip_link);

# ╔═╡ 93188ea6-3074-4780-8575-4253921e5d52
philip_img=load(philip_img_f)

# ╔═╡ 38795d2b-ab1d-4542-b425-331ed8593d17
md"""
## Códigos e programação

Claro a maior parte das funcionalidades do **notebook** vai estar diretamente com programação. No caso o **Pluto** foi desenvolvido na linguagem ```Julia```. Essa linguagem de programação é relativamente nova, sendo lançada em [2012](https://pt.wikipedia.org/wiki/Julia_(linguagem_de_programação)), contudo apenas em 2018 se tornou uma linguagem utilizavel pelo plubico comum.


A razão do porque este **notebook** foi desenvolvido em ```Julia``` está diretamente relacionado com a velocidade da linguagem e sua simplicidade. Ela é uma linguagem dinâmica, ou seja não são precisos declarar tipos antecipadamente, contudo, ela consegue obter performance similares às de [C/C++](https://benchmarksgame-team.pages.debian.net/benchmarksgame/fastest/julia-gcc.html).

Assim foi possível criar um **notebook** que fosse ao mesmo tempo *reativo* e que não dependesse de maquinas poderosas para execução.

Como a linguagem ```Julia``` ainda foi implementada baseada em ```UTF-8```, é possível programar usando inclusive emojis e simbolos em *grego*.

σ ou ✋

"""

# ╔═╡ d0cebda6-38c9-41d6-b9a6-ac82dbaac6a5
md"""
## Linguagem Julia

Como a linguagem ```Julia``` é parte fundamental do uso deste **notebook** só será apresentado um conjunto básicos de operações e uso da linguagem. É importante ressaltar que a sintaxe é muito simples, lembrando tanto ```Python``` quanto ```Matlab```.

Primeiro, para declarar uma variável pode-se fazer:
"""

# ╔═╡ 853a00c7-fe94-4e07-b61c-eb19179082a2
variável=1.0

# ╔═╡ 4a96a373-01bd-4f99-b17a-0686d782830b
md"""
Assim pode-se operar com ela como é feito em demais linguagens sem grandes dificuldades, por exemplo:
"""

# ╔═╡ f3c870d2-1ac6-44fa-98a3-aa38c777261f
variável+1

# ╔═╡ f0f1b644-3569-4728-aa94-e51b038ff889
md"""
Uma questão importante desse **notebook** é que quando se deseja realizar várias operações em uma mesma célula deve-se incluir o código dentro de um bloco ```begin-end```, como apresentado a seguir:
"""

# ╔═╡ e6b95098-ed7d-4e23-a02c-6c0528678b59
begin
	a=1
	b=3.0
	c=a+b
	d=b^a*2
end

# ╔═╡ 5cd656f1-3b17-4270-bf51-6cedebcd943a
md"""
Como é padrão na linguagem ```Julia``` o resultado da última operação de um bloco será retornado. Para omitir esse retorno é possível adicionar ";" no final do bloco.
"""

# ╔═╡ 76743399-a50f-4425-83a3-bb91053d4f40
md"""
### Iteratividade básica

Além do **notebook** os desenvolvedores do Pluto incluiram um pacote que consegue adicionar grandes funcionalidades de iteratividade para simples implementação, o ```PlutoUI```.

Ele foi adicionado no começo deste **notebook**, assim podemos usar facilmente as funções iterativas fornecidas, por exemplo, podemos criar um slides simples para valoreses atribudos em uma variável.
"""

# ╔═╡ 699e58f5-c842-4c9e-98f6-6924aa593d2b
@bind slider_ex Slider(0:10)

# ╔═╡ aa1d5280-e0c2-463b-a7fb-9144d7639545
slider_ex

# ╔═╡ 9cb28926-5dd2-4964-be7f-88459548575e
md"""
Diferentes formatações podem ser feitas e como o **notebook** converte o texto em *markdown* para *HTML* durante execução, é possível formatar diretamente de dentro do bloco de texto, por exemplo:

xₛ= $(@bind xₛ Slider(2.5:0.1:π,show_value=true, default=2.6))
"""

# ╔═╡ 91637125-43af-4bf7-a6c2-e7e7c3f99bf6
xₛ*2.0

# ╔═╡ 32b892ce-34bd-477d-b239-5714af4bf409
md"""
Outros exemplos de iteratividade podem ser:

caixa de texto = $(@bind texbox TextField())

seleção de tempo: $(@bind lunch_time TimeField())

caixa de números= $(@bind numfield NumberField(0.00 : 0.01 : 0.30))

seleção de lista: $(@bind veg Select(["potato" => "🥔", "carrot" => "🥕"], default="carrot"))

Radio: $(@bind veg2 Radio(["potato" => "🥔", "carrot" => "🥕"], default="carrot"))

botão: $(@bind go Button("Go!"))


Mais exemplos de utilidades da biblioteca ```PlutoUI``` podem ser encontradas em: [https://juliahub.com/docs/PlutoUI/abXFp/0.7.6/autodocs/](https://juliahub.com/docs/PlutoUI/abXFp/0.7.6/autodocs/) ou através dos vídeos da comunidade ```Julia``` através do canal deles do youtube: [https://www.youtube.com/user/JuliaLanguage](https://www.youtube.com/user/JuliaLanguage)


"""

# ╔═╡ 149e0cc8-1a4e-4a0e-88ac-e31bb4c99136
md"""
### Gráficos

Para visualização de resultados e de funções é possível utilizar o pacote ```Plots.jl``` que possuem grande varidade de gráficos e funções de alta performance.
"""

# ╔═╡ 6ddd9b7b-5479-42b1-ac31-178c0fa3a556
md"""Para demonstrar isso podemos usar uma simples função de segundo grau:

$$f(x)=x^2-βx+3$$

onde α será um parametro que poderemos variar posteriormente. Para começo, assumiremos $β = π$.
"""

# ╔═╡ 64586b01-fe84-40a0-82c9-0486032be1ac
f1(x)=x.^2 .-π.*x .+3.0

# ╔═╡ f244eda6-d45a-466f-be67-d04fdb4b7580
x_plot=[0:0.01:3];

# ╔═╡ 24ea9ddd-0dd9-4dea-8817-4f88fb4bc294
plot(x_plot,f1.(x_plot),xlabel="x",ylabel="f(x)")

# ╔═╡ dec1f81c-6425-4403-97de-16e2e6234e8e
md"""
Agora vamos adicionar um slider e tornar os gráficos iterativos...

β= $(@bind β Slider(0.85π:0.01:1.5π,show_value=true, default=π*1.0))
"""

# ╔═╡ 69d2a394-2af9-41fb-90b9-7d44adc06184
f2(x)=x.^2 .-β.*x .+3.0

# ╔═╡ cd78a714-ba02-46b2-8105-1ef96b042872
begin
	plot(f1,xlabel="x",ylabel="f(x)",label="Base Plot",lw=1.5)
	plot!(f2,linestyle=:dash,label="Iterative",lw=2)
end

# ╔═╡ ffdeaed4-58a8-4af1-88fa-46d14b41f3c9
md"""
## Problemas diferenciais

Por fim um exemplo de uma EDO resolvida.


Vamos usar a tradicional:

$$\frac{du}{dt}=γu$$

Se testarmos para $γ=1.01$ a solução para este problema será:

$$u(t)=u₀\exp(1.01t)$$

Assim, podemos usar este exemplo em conjunto do pacote ```DifferentialEquations``` para resolver esta EDO.

Para fazer isso, primeiro, é precisodeclarar o problema diferencial. Isso pode ser feito por meio de:

"""

# ╔═╡ 4b37c2d9-6718-4d13-8619-48bce64bbcdd
begin
	f(u,p,t) = 1.01*u
	u0 = 1/2
	tspan = (0.0,1.0)
	prob = ODEProblem(f,u0,tspan)
end

# ╔═╡ 0c4dce74-0880-494c-8084-0f7bc4784b1e
md"""
Para resolver esse problema podemos usar a função ```solve```. A mesma recebe alguns parametros, o primeiro será o método escolhido para fazer a integração do problema. Para este exemplo um Runge-Kutta de 4ᵃ ordem foi selecionado, contudo, o pacote conta com mais de 70 solvers diferentes que poderiam ser testados aqui. 

"""

# ╔═╡ e1e4e1ec-9cfc-423b-b50b-bf892dc6eae1
sol=solve(prob,RK4(), reltol = 1e-8)

# ╔═╡ 370cd453-7c1c-468c-8cc4-7b8e7bd3e894
md"""
Uma funcionalidade muito importante da solução deste problema é o comportamento tanto de vetor quanto de função dependendo de como chamar a solução.

Por exemplo, ao chamarmos a solução como um vetor ele ira retornar o resultado em um dado ponto específico.
"""

# ╔═╡ f7a1a2db-bb5d-4a69-bdbc-b200a36147e2
sol[1],sol[4]

# ╔═╡ 9ac432fc-46f6-4954-b701-b7864a4adc48
md"""
Por outro lado, caso chamemos a solução como uma função, automaticamente será usado um interpolador cuja ordem de interpolação é automaticamente ajustada ao solver utilizado. 

Por exemplo, caso chamemos a solução no tempo $t=0.2$, a solução será o resultado de uma interpolação nesse ponto.
"""

# ╔═╡ 37668c8b-31b4-459f-8cba-4db86c94626e
sol(0.20)

# ╔═╡ cec483fd-c489-47b3-ab50-226678d0d644
md"""
Em representação gráfica, o autor do pacote incluiu uma receita para que os plots sejam feitos automaticamente.
"""

# ╔═╡ 45ba7464-5ef0-467c-bc7f-e7fc02727e9a
plot(sol)

# ╔═╡ 15874c4e-cf63-4ab1-8fa7-ef42c15e66c0
md"""
## Acoplamento com erros de medição

Agora uma interação interessante e acidental que ocorreu na linguagem ```Julia``` envolvem o pacote ```DifferentialEquations``` e o pacote ```Measurements```. O segundo pacote é usado para adicionar questões como imprecisões decorrentes de medição nas analises. 

Ele inclui o opreador ± que pode ser usado para incluir o erro esperado de medição em uma dada variável. A propagação de incertezas é feita automáticamente e como consequencia do *Multiple Dispatch* da linguagem, consegue ser usado por muitos pacotes, mesmo sem necessitar adição de código extra.

Um ótimo exemplo disso é essa interação entre ```DifferentialEquations``` e ```Measurements```. Esses pacotes podem ser usados em conjunto para adicionar incertezas ao processo de integração de equações diferenciais. Para isso basta incluir incertezas, mesmo que nulas, na condição inicial e adicionar em demais equações que forem pertinentes.

Podemos então usar o proprio exemplo anterior adicionando 10% de imprecisão no γ, bem como 1% de imprecisão na medição da condição inicial.

Isso é feito por meio de:

"""

# ╔═╡ 2ebdbf96-14fb-40ec-8f78-88444f9df967
teste=1.0±0.1

# ╔═╡ 38f4cdf0-d090-4d22-923a-8b975bcfa7b3
teste+0.5teste

# ╔═╡ 98f7bc06-2a9e-4fba-8226-c37baba42372
begin		
	γ=1.01±1.01*0.1
	f_meas(u,p,t) = γ.*u
	u0_m = 1/2± 1/2*0.01
	tspan_m = (0.0,1.0)
	prob2 = ODEProblem(f_meas,u0_m,tspan_m)
end

# ╔═╡ 3c583642-8694-499f-a4e8-f48b8baa9dc0
md"""
Note que o tipo do resultado do problema ODE será do tipo ```Measurement{Float64}```.

Para resolver esse novo problema, pode-se usar o mesmo solver sem nenhuma modificação. A principal diferença estará no resultado, que agora terá a incerteza propagada automaticamente.
"""

# ╔═╡ 7f47d73e-c2d4-48fb-ac67-5c5be9781c53
sol2=solve(prob2,RK4(), reltol = 1e-8)

# ╔═╡ 75c104df-0ce9-41f2-be34-fc51d38050fd
md"""
Por fim, o autor do pacote de equações diferenciais adicionou uma receita de gráficos de modo que, quando plotando resultados com incertezas, barras de erro serão automaticamente adicionadas nos pontos simulados. O gráfico a seguir mostra exatamente essa questão, com um incerteza pequena no começo claramente cresce em tempos maiores.
"""

# ╔═╡ e10e245d-0160-4acc-ba01-5d738911e854
begin
	u=sol.u
	u2=sol2.u
	plot(sol.t,sol.u,linestyle=:dot,lw=1.5)
	plot!(sol2.t,sol2.u,linestyle=:dash,lw=1.5,label="measurement")
end

# ╔═╡ e0d623a4-9ce3-4a5d-940c-2693d5c411b8
md"""
## Problema clássico interativo

Um exemplo clássico de interatividade do **notebook** envolve modelos *SIR* para modelar transmissão de vírus (o momento atual aumentou a popularidade). Podemos então definir as *EDO*s de modo que:

$$\frac{dS}{dt}=-β S I$$
$$\frac{dI}{dt}=β S I-γ I$$
$$\frac{dR}{dt}=γ I$$
com $S$ o número de pessoas sucetiveis à doença, $I$ o número de infectados e $R$ o número de recuperados.


"""

# ╔═╡ 4e6367cf-d09d-498c-98c3-5533e02633dc
sir_ode = @ode_def SIRModel begin
    dS = -β*S*I
    dI = β*S*I-γ*I
    dR = γ*I
    end β γ

# ╔═╡ 1a4a864f-1079-40db-b242-3b25273f4948
md"""
βₛ= $(@bind βₛ Slider(0.05:0.01:0.25,show_value=true,default=0.1))
γₛ= $(@bind γₛ Slider(0.01:0.0005:0.025,show_value=true,default=0.015))
"""

# ╔═╡ bad1f201-3c20-469f-933f-10dd3ac2f94d
begin
	parms = [βₛ,γₛ]#.±0.0025
	init = [0.99,0.01,0.0]#.±0.001
	tspan_SIR = (0.0,150.0)
end

# ╔═╡ 79ba3966-8463-4fea-8e24-051c1d916390
sir_prob = ODEProblem(sir_ode,init,tspan_SIR,parms)

# ╔═╡ 6ac982a0-e393-4c06-88eb-7ec798c65072
sir_sol = solve(sir_prob,RK4(),saveat = 1.0);

# ╔═╡ 038502c5-fd71-4305-81d7-b0c16ff8c0d4
plot(sir_sol,xlabel="Time",ylabel="Number")

# ╔═╡ d7d633dc-7d66-4d8c-9135-fa70444dc6ea
sir_sol

# ╔═╡ 56afb21c-e994-46bc-8bb1-c3011001e25e
function blue(s::String)
	HTML("<span style='color:blue'> $(s)  </span>")
end;

# ╔═╡ c7655f51-dc74-40e4-8a9f-8baba92b582f
md"""
## Divisão de tópicos

O notebook **Pluto** conta com a capacidade de usar o padrão *markdown* para tratar de trecho de textos e organização de documentos.

O *markdown* é muito usado por ser simples. Além disso permite divisão em tópicos conforme este notebook está formatado. Para mais informações sobre o *markdown* é possível pesquisar sobre o tópico separadamente, a fonte a seguir pode ser útil: [Wikipédia Markdown](https://pt.wikipedia.org/wiki/Markdown).

Como já se pode perceber é possível incluir divérsos *links* e funcionalidades ao notebook sem grande dificuldade. O motivo que permite isso está ligado ao fato do **notebook** converter e formatar este arquivo com base em um interpetrador de *HTML*, assim permitindo incluir virtualmente qualquer funcionalidade, contanto que se entenda de *HTML*.

Outra questão importante é que este **notebook** consegue interpetrar e apresentar equações formatadas em $\LaTeX$, assim podemos incluir equações complexas formatadas com simplicidade. Por exemplo:

$$f(x)=x^2+2x-3$$

Além dessas funções básicas de organização o **notebook** também consegue lidar com listas e mais outros formatos nativos de *markdown*.

Lista não ordenada:
* Exemplo
* de
* lista

Lista ordenada:
1. Exemplo
2. lista
3. Odernada

Pode-se tambem destacar trechos de textos em caixas individuais:

>Exemplo de texto em destace por caixa

Ou ainda podem ser apresentadas tabelas simples como:

First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column



Outras funcionalidades como mudar a cor de texto $(blue("por exemplo")).

Enfim as possibilidades de edição do texto são muito grandes.


"""

# ╔═╡ Cell order:
# ╠═65bad610-a606-11eb-1058-016b40953c55
# ╟─85b9ab0e-eb1d-47ed-956d-39dea6a46fbc
# ╠═8cf10a61-6e4a-4906-92a0-3d79105821cb
# ╟─c90b1f2a-c307-422d-9012-d81626c8371f
# ╟─a12e82cb-b32b-4220-bf6e-e16a9cf2ccdd
# ╟─c7655f51-dc74-40e4-8a9f-8baba92b582f
# ╟─e03e002b-2cb3-43f8-a3bc-7511d8c610e6
# ╟─d2d3386c-5bb6-4b25-aaab-66dd332434b0
# ╠═124e4008-bc25-4b70-86bd-680b18cf5c4e
# ╠═a62a2989-dc16-49b8-888f-6ce958e84f31
# ╠═93188ea6-3074-4780-8575-4253921e5d52
# ╟─38795d2b-ab1d-4542-b425-331ed8593d17
# ╟─d0cebda6-38c9-41d6-b9a6-ac82dbaac6a5
# ╠═853a00c7-fe94-4e07-b61c-eb19179082a2
# ╟─4a96a373-01bd-4f99-b17a-0686d782830b
# ╠═f3c870d2-1ac6-44fa-98a3-aa38c777261f
# ╟─f0f1b644-3569-4728-aa94-e51b038ff889
# ╠═e6b95098-ed7d-4e23-a02c-6c0528678b59
# ╟─5cd656f1-3b17-4270-bf51-6cedebcd943a
# ╟─76743399-a50f-4425-83a3-bb91053d4f40
# ╠═699e58f5-c842-4c9e-98f6-6924aa593d2b
# ╠═aa1d5280-e0c2-463b-a7fb-9144d7639545
# ╟─9cb28926-5dd2-4964-be7f-88459548575e
# ╠═91637125-43af-4bf7-a6c2-e7e7c3f99bf6
# ╟─32b892ce-34bd-477d-b239-5714af4bf409
# ╟─149e0cc8-1a4e-4a0e-88ac-e31bb4c99136
# ╟─6ddd9b7b-5479-42b1-ac31-178c0fa3a556
# ╠═64586b01-fe84-40a0-82c9-0486032be1ac
# ╟─f244eda6-d45a-466f-be67-d04fdb4b7580
# ╠═24ea9ddd-0dd9-4dea-8817-4f88fb4bc294
# ╟─dec1f81c-6425-4403-97de-16e2e6234e8e
# ╠═69d2a394-2af9-41fb-90b9-7d44adc06184
# ╠═cd78a714-ba02-46b2-8105-1ef96b042872
# ╟─ffdeaed4-58a8-4af1-88fa-46d14b41f3c9
# ╠═4b37c2d9-6718-4d13-8619-48bce64bbcdd
# ╟─0c4dce74-0880-494c-8084-0f7bc4784b1e
# ╠═e1e4e1ec-9cfc-423b-b50b-bf892dc6eae1
# ╟─370cd453-7c1c-468c-8cc4-7b8e7bd3e894
# ╠═f7a1a2db-bb5d-4a69-bdbc-b200a36147e2
# ╟─9ac432fc-46f6-4954-b701-b7864a4adc48
# ╠═37668c8b-31b4-459f-8cba-4db86c94626e
# ╟─cec483fd-c489-47b3-ab50-226678d0d644
# ╠═45ba7464-5ef0-467c-bc7f-e7fc02727e9a
# ╟─15874c4e-cf63-4ab1-8fa7-ef42c15e66c0
# ╠═2ebdbf96-14fb-40ec-8f78-88444f9df967
# ╠═38f4cdf0-d090-4d22-923a-8b975bcfa7b3
# ╠═98f7bc06-2a9e-4fba-8226-c37baba42372
# ╟─3c583642-8694-499f-a4e8-f48b8baa9dc0
# ╠═7f47d73e-c2d4-48fb-ac67-5c5be9781c53
# ╟─75c104df-0ce9-41f2-be34-fc51d38050fd
# ╠═e10e245d-0160-4acc-ba01-5d738911e854
# ╟─e0d623a4-9ce3-4a5d-940c-2693d5c411b8
# ╠═4e6367cf-d09d-498c-98c3-5533e02633dc
# ╟─1a4a864f-1079-40db-b242-3b25273f4948
# ╠═bad1f201-3c20-469f-933f-10dd3ac2f94d
# ╠═79ba3966-8463-4fea-8e24-051c1d916390
# ╠═6ac982a0-e393-4c06-88eb-7ec798c65072
# ╠═038502c5-fd71-4305-81d7-b0c16ff8c0d4
# ╠═d7d633dc-7d66-4d8c-9135-fa70444dc6ea
# ╟─56afb21c-e994-46bc-8bb1-c3011001e25e
