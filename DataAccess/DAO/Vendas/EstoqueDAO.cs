using DataAccess.Models;
using DataAccess.Utils;
using System;
using System.Data;
using System.Data.SqlClient;

namespace DataAccess.DAO
{
    public class EstoqueDAO : PadraoDAO<EstoqueViewModel>
    {
        protected LivroDAO LivroDAO { get; set; } = new LivroDAO();
        protected LivrariaDAO LivrariaDAO { get; set; } = new LivrariaDAO();


        protected override SqlParameter[] CriaParametros(EstoqueViewModel model)
        {
            throw new Exception("Não é permitido inserir diretamente um valor de estoque. Esse dado é calculado no banco");
        }

        protected override EstoqueViewModel MontaModel(DataRow registro)
        {
            var retorno = new EstoqueViewModel();
            // Estoque não possui ID, pois é uma view
            //retorno.Id = Convert.ToInt32(registro[nameof(retorno.Id)]);
            retorno.Livro = LivroDAO.Consulta(Convert.ToInt32(registro["Livro_Id"]));
            retorno.Livraria = LivrariaDAO.Consulta(Convert.ToInt32(registro["Livraria_Id"]));
            retorno.Quantidade = Convert.ToInt32(registro[nameof(retorno.Quantidade)]);

            return retorno;
        }

        protected override void SetTabela()
        {
            Tabela = EnumTabela.VW_Estoque;
        }
    }
}
