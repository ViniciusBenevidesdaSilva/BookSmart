using DataAccess.Models;
using DataAccess.Utils;
using System;
using System.Data;
using System.Data.SqlClient;

namespace DataAccess.DAO
{
    public class LivrariaDAO : PadraoDAO<LivrariaViewModel>
    {
        protected override SqlParameter[] CriaParametros(LivrariaViewModel model)
        {
            var p = new SqlParameter[]
            {
                new SqlParameter(nameof(model.Id), HelperDAO.NullAsDbNull(model.Id)),
                new SqlParameter(nameof(model.Nome), model.Nome),
                new SqlParameter(nameof(model.CNPJ), model.CNPJ),
                new SqlParameter(nameof(model.CEP), model.CEP),
                new SqlParameter(nameof(model.UF), model.UF),
                new SqlParameter(nameof(model.Cidade), model.Cidade),
                new SqlParameter(nameof(model.Bairro), model.Bairro),
                new SqlParameter(nameof(model.Logradouro), model.Logradouro),
                new SqlParameter(nameof(model.Numero), HelperDAO.NullAsDbNull(model.Numero))
            };

            return p;
        }

        protected override LivrariaViewModel MontaModel(DataRow registro)
        {
            var retorno = new LivrariaViewModel();
            retorno.Id = Convert.ToInt32(registro[nameof(retorno.Id)]);
            retorno.Nome = registro[nameof(retorno.Nome)].ToString();
            retorno.CNPJ = registro[nameof(retorno.CNPJ)].ToString();
            retorno.CEP = registro[nameof(retorno.CEP)].ToString();
            retorno.UF = registro[nameof(retorno.UF)].ToString();
            retorno.Cidade = registro[nameof(retorno.Cidade)].ToString();
            retorno.Bairro = registro[nameof(retorno.Bairro)].ToString();
            retorno.Logradouro = registro[nameof(retorno.Logradouro)].ToString();
            retorno.Numero = HelperDAO.DbNullAsString(registro[nameof(retorno.Numero)]);

            return retorno;
        }

        protected override void SetTabela()
        {
            Tabela = EnumTabela.Livrarias;
        }
    }
}
