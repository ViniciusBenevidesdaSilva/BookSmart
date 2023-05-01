using DataAccess.Utils;

namespace DataAccess.Models
{
    public class LivroRFIDViewModel : PadraoForeignViewModel<LivroViewModel>
    {
        public LivroViewModel Livro
        {
            get => ForeignKey;
            set => ForeignKey = value;
        }
        public LivrariaViewModel Livraria { get; set; } = new LivrariaViewModel();
        public string Rfid { get; set; }
        public EnumFlagDisponibilidade Flag_disponivel { get; set; }
    }
}
