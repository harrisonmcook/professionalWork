using Yellowbrick.Models.Domain.Lookups;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Yellowbrick.Models.Domain
{
    public class HouseHold
    {
        public int Id { get; set; }
        public Client Client { get; set; }
        public bool IsMarried { get; set; }
        public bool HasKids { get; set; }
        public LookUp Status { get; set; }
        public string SpouseName { get; set; }
        public string SpouseLastName { get; set; }
        public string SpouseMi { get; set; }
        public string SpouseDob { get; set; }
        public string SpousePhone { get; set; }
        public string SpouseEmail { get; set; }
        public int KidsNumber { get; set; }
        public List<int> ChildAges { get; set; }
        public BaseUser CreatedBy { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateModified { get; set; }
    }
}
//
