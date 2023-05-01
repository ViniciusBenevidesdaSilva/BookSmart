﻿using DataAccess.Models;
using DataAccess.Utils;
using System;
using System.Data;
using System.Data.SqlClient;

namespace DataAccess.DAO
{
    public class GeneroDAO : PadraoDAO<GeneroViewModel>
    {
        protected override SqlParameter[] CriaParametros(GeneroViewModel model)
        {
            var p = new SqlParameter[]
            {
                new SqlParameter(nameof(model.Id), HelperDAO.NullAsDbNull(model.Id)),
                new SqlParameter(nameof(model.Descricao), model.Descricao)
            };

            return p;
        }

        protected override GeneroViewModel MontaModel(DataRow registro)
        {
            var retorno = new GeneroViewModel();
            retorno.Id = Convert.ToInt32(registro[nameof(retorno.Id)]);
            retorno.Descricao = registro[nameof(retorno.Descricao)].ToString();
            return retorno;
        }

        protected override void SetTabela()
        {
            Tabela = EnumTabela.Generos;
        }
    }
}
