# Vrpex-Admin-Painel-
peguei a ideia de video gringo e trouxe para o VRPEX, pretendo implantar algumas coisas a mais conforme for aprendendo front-end
Caso use, nao esqueça de deixar os devidos, creditos um beijo para vocês meus caros compatriotas da comunidade <3

va na sua pasta vrp/cfg/groups.lua e adicione 

    ["Staff"] = {
        _config = {
            title = "Staff Serviço",
            gtype = "staff"
        },
        "staff.permissao",

    },
    ["Off-staff"] = {
        _config = {
            title = "Fora de Servico",
            gtype = "staff"
        },
        "off-staff.permissao",
    },
    
    
   arrume as permissões do seu servidor no lado server-side
   Discord: MITSU#3867, caso precise tirar alguma duvida.
