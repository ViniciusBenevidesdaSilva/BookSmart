using DataAccess.DAO;
using DataAccess.Models;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BookSmart_Portal.Controllers
{
    public class ClienteController : PadraoController<ClienteViewModel>
    {
        public ClienteController()
        {
            DAO = new ClienteDAO();
            GeraProximoId = true;
        }

        protected override void PreencheDadosParaView(string Operacao, ClienteViewModel model)
        {
            base.PreencheDadosParaView(Operacao, model);
        }

        protected override void ValidaDados(ClienteViewModel model, string operacao)
        {
            base.ValidaDados(model, operacao);

            //if (string.IsNullOrEmpty(model.Nome))
            //    ModelState.AddModelError("Nome", "Preencha o nome.");
            //if (model.Mensalidade < 0 || model.Mensalidade == null)
            //    ModelState.AddModelError("Mensalidade", "Campo obrigatório.");
            //if (model.CidadeId <= 0)
            //    ModelState.AddModelError("CidadeId", "Informe o código da cidade.");
            //if (model.DataNascimento > DateTime.Now)
            //    ModelState.AddModelError("DataNascimento", "Data inválida!");
        }

        //private void PreparaListaCidadesParaCombo()
        //{
        //    CidadeDAO cidadeDao = new CidadeDAO();
        //    var cidades = cidadeDao.Listagem();
        //    List<SelectListItem> listaCidades = new List<SelectListItem>();
        //    listaCidades.Add(new SelectListItem("Selecione uma cidade...", "0"));
        //    foreach (var cidade in cidades)
        //    {
        //        SelectListItem item = new SelectListItem(cidade.Nome, cidade.Id.ToString());
        //        listaCidades.Add(item);
        //    }
        //    ViewBag.Cidades = listaCidades;
        //}
    }
}
