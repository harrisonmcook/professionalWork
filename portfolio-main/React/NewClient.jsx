import React from "react";
import { useState } from "react";
import Loki from "react-loki";
import PersonalInformation from "./PersonalInformation";
import ShortTermDebt from "./debts/ShortTermDebt";
import Mortgages from "./housing/Mortgages";
import ClientProtection from "./protection/ClientProtection";
import ClientEmployment from "./employment/ClientEmployment";
import ClientIncome from "./income/ClientIncome";
import InvestmentAccounts from "./assets/InvestmentAccounts";
import RetirementAccounts from "./assets/RetirementAccounts";
import ClientProperties from "./assets/ClientProperties";
import HealthInsurance from "./protection/HealthInsurance";
import debug from "sabio-debug";
import "./newclientloki.css";
import "bootstrap/dist/css/bootstrap.min.css";
import {
  FaUser,
  FaBriefcase,
  FaMoneyBillWave,
  FaHospitalUser,
  FaHouseUser,
  FaMoneyCheck,
  FaFileInvoiceDollar,
  FaGlassCheers,
  FaCity,
  FaBookMedical,
} from "react-icons/fa";

function NewClient() {
  const [clientInfo, setClientInfo] = useState({
    client: {
      id: 0,
      firstName: "",
      lastName: "",
      middleInitial: "",
      dob: "",
      email: "",
      phone: "",
      isMarried: false,
      spouseFirstName: "",
      spouseLastName: "",
      spouseMi: "",
      spouseDOB: "",
      spouseEmail: "",
      spousePhone: "",
      hasKids: false,
      kidsNumber: "",
      kidsAges: "",
      hasNoKids: false,
      hasKids: false,
      f: 1,
    },
    location: {
      locationTypeId: "",
      lineOne: "",
      lineTwo: "",
      city: "",
      zip: "",
      stateId: 0,
      latitude: 0,
      longitude: 0,
    },
  });
  const _logger = debug.extend("newClient");
  const passClientData = (idValue, values, locationId) => {
    setClientInfo((pd) => {
      const ps = { ...pd };
      ps.client = { ...values };
      ps.client.id = idValue;
      ps.client.locationId = locationId;

      return ps;
    });
  };
  const passLocationData = (locationData, locationId) => {
    setClientInfo((pd) => {
      const ps = { ...pd };
      ps.location = { ...locationData };
      ps.location.id = locationId;

      return ps;
    });
  };

  const mySteps = [
    {
      label: "Step 1",
      icon: <FaUser className="mt-3" />,
      component: (
        <PersonalInformation
          clientId={clientInfo.client.id}
          giveClient={passClientData}
          defaultPersonalInfo={clientInfo.client}
          defaultLocation={clientInfo.location}
          giveLocation={passLocationData}
          isInStepper={true}
        />
      ),
    },
    {
      label: "Step 2",
      icon: <FaMoneyCheck className="mt-3" />,
      component: <ShortTermDebt clientId={clientInfo.client.id} />,
    },
    {
      label: "Step 3",
      icon: <FaHouseUser className="mt-3" />,
      component: <Mortgages clientId={clientInfo.client.id} />,
    },
    {
      label: "Step 4",
      icon: <FaHospitalUser className="mt-3" />,
      component: <ClientProtection clientId={clientInfo.client.id} />,
    },
    {
      label: "Step 5",
      icon: <FaBookMedical className="mt-3" />,
      component: (
        <HealthInsurance
          isMarried={clientInfo.client.isMarried}
          clientId={clientInfo.client.id}
        />
      ),
    },
    {
      label: "Step 6",
      icon: <FaCity className="mt-3" />,
      component: <ClientProperties clientId={clientInfo.client.id} />,
    },
    {
      label: "Step 7",
      icon: <FaFileInvoiceDollar className="mt-3" />,
      component: <InvestmentAccounts clientId={clientInfo.client.id} />,
    },
    {
      label: "Step 8",
      icon: <FaGlassCheers className="mt-3" />,
      component: <RetirementAccounts clientId={clientInfo.client.id} />,
    },
    {
      label: "Step 9",
      icon: <FaBriefcase className="mt-3" />,
      component: <ClientEmployment clientId={clientInfo.client.id} />,
    },
    {
      label: "Step 10",
      icon: <FaMoneyBillWave className="mt-3" />,
      component: <ClientIncome clientId={clientInfo.client.id} />,
    },
  ];

  const finishWizard = () => {
    _logger("finish");
  };
  //placeholder, we are not sure what we will want to happen on finish yet//

  return (
    <>
      <div className="border-bottom pb-4 mb-4 d-lg-flex justify-content-between align-items-center">
        <div className="mb-3 mb-lg-0">
          <h1 className="mb-0 h2 fw-bold">Add New Client</h1>
        </div>
      </div>

      <div className="newClientWizard">
        <Loki
          steps={mySteps}
          onNext={finishWizard}
          onFinish={finishWizard}
          noActions
        />
      </div>
    </>
  );
}
export default NewClient;
