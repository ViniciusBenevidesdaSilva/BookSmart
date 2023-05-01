using System;
using System.Collections.Generic;

namespace DataAccess.Models
{
    public class VendaViewModel : PadraoViewModel
    {
        public DateTime Data_venda { get; set; }
        public LivrariaViewModel Livraria { get; set; } = new LivrariaViewModel();
        public ClienteViewModel Cliente { get; set; } = new ClienteViewModel();
        public List<VendaLivroViewModel> Livros { get; set; } = new List<VendaLivroViewModel>();

    }
}


