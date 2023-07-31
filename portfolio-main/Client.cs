using Sabio.Models.Domain.Lookups;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Sabio.Models.Domain
{
    public class Client : ClientBase
    {

        public string DOB { get; set; }
        public LookUp Status { get; set; }
        public Location Location { get; set; }
        public string Phone { get; set; }
        public string Email { get; set; }
        public bool HasFamily { get; set; }
        public BaseUser CreatedBy { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }



    }
}
