using System;

namespace DataAccess.Models
{
    public class AvaliacaoViewModel : PadraoForeignViewModel<LivroViewModel>
    {
        public ClienteViewModel Cliente { get; set; } = new ClienteViewModel();
        public LivroViewModel Livro
        {
            get => ForeignKey;
            set => ForeignKey = value;
        }
        public DateTime Data_Avaliacao { get; set; }
        public int Nota { get; set; }
        public string Resenha { get; set; } = null;

    }
}
