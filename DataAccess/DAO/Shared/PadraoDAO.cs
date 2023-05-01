using DataAccess.Models;
using DataAccess.Utils;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace DataAccess.DAO
{
    public abstract class PadraoDAO<T> where T : PadraoViewModel
    {
        public PadraoDAO()
        {
            SetTabela();
        }

        protected EnumTabela Tabela { get; set; }
        protected string NomeSpListagem { get; set; } = "spListagem";


        protected abstract SqlParameter[] CriaParametros(T model);
        protected abstract T MontaModel(DataRow registro);
        protected abstract void SetTabela();


        public virtual void Insert(T model)
        {
            if (model == null)
                return;

            HelperDAO.ExecutaProc($"spInsert_{Tabela}", CriaParametros(model));
            model.Id = ProximoId();
        }
        public virtual void Update(T model)
        {
            if (model == null)
                return;

            HelperDAO.ExecutaProc($"spUpdate_{Tabela}", CriaParametros(model));
        }
        public virtual void Delete(int? id)
        {
            var p = new SqlParameter[]
            {
                new SqlParameter("id", HelperDAO.NullAsDbNull(id)),
                new SqlParameter("tabela", Tabela.ToString())
            };
            HelperDAO.ExecutaProc("spDelete", p);
        }
        public virtual T Consulta(int? id)
        {
            var p = new SqlParameter[]
            {
                new SqlParameter("id", HelperDAO.NullAsDbNull(id)),
                new SqlParameter("tabela", Tabela.ToString())
            };
            var tabela = HelperDAO.ExecutaProcSelect("spConsulta", p);
            if (tabela.Rows.Count == 0)
                return null;
            else
                return MontaModel(tabela.Rows[0]);
        }

        /// <summary>
        /// Retorna o último Id inserido naquela tabela em específico.
        /// </summary>
        /// <returns></returns>
        public virtual int ProximoId()
        {
            var p = new SqlParameter[]
            {
                new SqlParameter("tabela", Tabela.ToString())
            };
            var tabela = HelperDAO.ExecutaProcSelect("spProximoId", p);
            return Convert.ToInt32(tabela.Rows[0][0]);
        }
        public virtual List<T> Listagem()
        {
            var p = new SqlParameter[]
            {
                new SqlParameter("tabela", Tabela.ToString()),
            };
            var tabela = HelperDAO.ExecutaProcSelect(NomeSpListagem, p);
            List<T> lista = new List<T>();
            foreach (DataRow registro in tabela.Rows)
                lista.Add(MontaModel(registro));

            return lista;
        }

    }
}
