using DataAccess.Models;
using DataAccess.Utils;
using System;
using System.Data;
using System.Data.SqlClient;

namespace DataAccess.DAO
{
    public class VendaDAO : PadraoDAO<VendaViewModel>
    {
        protected LivrariaDAO LivrariaDAO { get; set; } = new LivrariaDAO();
        protected ClienteDAO ClienteDAO { get; set; } = new ClienteDAO();
        protected VendaLivroDAO VendaLivroDAO { get; set; } = new VendaLivroDAO();

        protected override SqlParameter[] CriaParametros(VendaViewModel model)
        {
            var p = new SqlParameter[]
            {
                new SqlParameter(nameof(model.Id), HelperDAO.NullAsDbNull(model.Id)),
                new SqlParameter(nameof(model.Data_venda), model.Data_venda),
                new SqlParameter("Livraria_Id", model.Livraria.Id),
                new SqlParameter("Cliente_Id", model.Cliente.Id)
            };

            return p;
        }

        protected override VendaViewModel MontaModel(DataRow registro)
        {
            var retorno = new VendaViewModel();
            retorno.Id = Convert.ToInt32(registro[nameof(retorno.Id)]);
            retorno.Livraria = LivrariaDAO.Consulta(Convert.ToInt32(registro["Livraria_Id"]));
            retorno.Cliente = ClienteDAO.Consulta(Convert.ToInt32(registro["Cliente_Id"]));
            retorno.Data_venda = Convert.ToDateTime(registro[nameof(retorno.Data_venda)]);

            retorno.Livros = VendaLivroDAO.Listagem(ref retorno);

            return retorno;
        }

        public override void Insert(VendaViewModel venda) 
        {
            base.Insert(venda);

            VendaLivroDAO.Insert(venda.Livros);
        }
        public override void Update(VendaViewModel venda)
        {
            base.Update(venda);

            VendaLivroDAO.Update(venda.Livros, venda);
        }

        protected override void SetTabela()
        {
            Tabela = EnumTabela.Vendas;
        }
    }
}
