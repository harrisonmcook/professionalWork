import React from "react";
import { useState, useEffect } from "react";
import { Formik, Field, Form, ErrorMessage } from "formik";
import debug from "yellowbrick-debug";
import clientService from "services/clientService";
import toastr from "toastr";
import { Collapse } from "react-bootstrap";
import "./personalinformationstyle.css";
import personalInformationSchema from "schemas/personalInformationSchema";
import PropTypes from "prop-types";
import LocationsForm from "components/location/LocationForm";
import locationServices from "services/locationService";

function ClientPersonal(props) {
  const [marriedVis, setMarriedVis] = useState(
    props.defaultPersonalInfo.isMarried === true ? true : false
  );
  const [kidsVis, setKidsVis] = useState(
    props.defaultPersonalInfo.hasKids === true ? true : false
  );
  const [locationData, setLocationData] = useState({});
  const _logger = debug.extend("personalInfo");
  useEffect(() => {
    setLocationData((ps) => {
      let pd = { ...ps };
      pd = props.defaultLocation;
      return pd;
    });
  }, []);

  const handleSubmit = (values) => {
    const childAges = () => {
      const ageNumberArray = [];
      let ageArray = values.kidsAges.split(",");
      for (let index = 0; index < ageArray.length; index++) {
        const currentAge = ageArray[index];
        let ageAsNumber = Number(currentAge);
        ageNumberArray.push(ageAsNumber);
      }
      return ageNumberArray;
    };
    const clientPayload = {
      firstName: values.firstName,
      lastName: values.lastName,
      mi: values.middleInitial ? values.middleInitial : null,
      dob: values.dob,
      phone: values.phone,
      email: values.email,
      hasFamily: values.isMarried | values.hasKids ? true : false,
      IsMarried: values.isMarried,
      SpouseName: values.isMarried ? values.spouseFirstName : null,
      SpouseLastName: values.isMarried ? values.spouseLastName : null,
      SpouseMi: values.isMarried && values.spouseMi ? values.spouseMi : null,
      SpouseDob: values.isMarried ? values.spouseDOB : null,
      SpousePhone: values.isMarried ? values.spousePhone : null,
      SpouseEmail: values.isMarried ? values.spouseEmail : null,
      hasKids: values.hasKids,
      KidsNumber: values.hasKids ? values.kidsNumber : null,
      ChildAges: values.hasKids ? childAges() : null,
    };
    const onClientSuccess = (r) => {
      props.giveClient(r.item, values, clientPayload.locationId);
      toastr["success"](
        `New client, ${values.firstName} ${values.lastName}, has been added`,
        "Client Added"
      );
      props.onNext();
    };
    const onClientFail = (e) => {
      _logger(e);
      toastr["error"]("Unable to add client", "Error Adding Client");
    };
    const onClientUpdateFail = (e) => {
      _logger(e);
      toastr["error"]("Unable to update client", "Error Updating Client");
    };
    const onClientUpdateSuccess = () => {
      props.giveClient(props.clientId, values);
      toastr["success"](
        `Client, ${values.firstName} ${values.lastName}, has been updated`,
        "Client Added"
      );
      props.onNext();
    };
    const onLocationSuccess = (r) => {
      props.giveLocation(locationData, r.data.item);
      clientPayload.locationId = r.data.item;
      clientService
        .add(clientPayload)
        .then(onClientSuccess)
        .catch(onClientFail);
    };
    const onLocationUpdateSuccess = () => {
      props.giveLocation(locationData, props.defaultLocation.id);
      clientPayload.locationId = props.defaultLocation.id;
      clientService
        .updateClient(props.clientId, clientPayload)
        .then(onClientUpdateSuccess)
        .catch(onClientUpdateFail);
    };
    const onLocationFail = (e) => {
      _logger(e);
      toastr["error"]("Couldn't input location.", "Error Inputting location");
    };
    if (props.clientId === 0) {
      locationServices
        .add(locationData)
        .then(onLocationSuccess)
        .catch(onLocationFail);
    } else {
      locationServices
        .updateLocation(props.defaultLocation.id, locationData)
        .then(onLocationUpdateSuccess)
        .catch(onLocationFail);
    }
  };

  const onLocationFormChange = (location) => {
    _logger(location);
    setLocationData((ps) => {
      const pd = { ...ps };
      (pd.locationTypeId = location.locationTypeId),
        (pd.lineOne = location.lineOne),
        (pd.city = location.city),
        (pd.zip = location.zip),
        (pd.lineTwo = location.lineTwo ? location.lineTwo : pd.lineTwo),
        (pd.stateId = location.stateId),
        (pd.latitude = location.latitude),
        (pd.longitude = location.longitude);
      pd.lineTwo = location.lineTwo === "" ? null : pd.lineTwo;
      return pd;
    });
  };

  return (
    <div className="mb-lg-0 mb-2 px-5 py-4 col-lg-10 col-md-10 col-sm-10">
      <span className="border">
        <div className="card shadow-lg">
          <div className="card-header">
            <h1>Personal Information</h1>
          </div>
          <div className="card-body bg-white">
            <Formik
              initialValues={props.defaultPersonalInfo}
              onSubmit={handleSubmit}
              enableReinitialize={true}
              validationSchema={personalInformationSchema}
            >
              {({ values }) => (
                <Form>
                  <div className="mb-3 row ">
                    <div className="col-4">
                      <label
                        className="form-label "
                        htmlFor="formGridfirstname"
                      >
                        First Name
                      </label>
                      <Field
                        name="firstName"
                        type="firstName"
                        id="firstName"
                        className="form-control"
                      />
                      <ErrorMessage
                        name="firstName"
                        component="div"
                        className="client-personal-input-error"
                      />
                    </div>
                    <div className="col-4">
                      <label className="form-label " htmlFor="formGridlastname">
                        Last Name
                      </label>
                      <Field
                        name="lastName"
                        type="lastName"
                        id="lastName"
                        className="form-control"
                      />
                      <ErrorMessage
                        name="lastName"
                        component="div"
                        className="client-personal-input-error"
                      />
                    </div>
                    <div className="col-1">
                      <label
                        className="form-label "
                        htmlFor="formGridmiddleInitial"
                      >
                        MI
                      </label>
                      <Field
                        name="middleInitial"
                        type="middleInitial"
                        id="middleInitial"
                        className="form-control"
                      />
                      <ErrorMessage
                        name="middleInitial"
                        component="div"
                        className="client-personal-input-error"
                      />
                    </div>
                    <div className="col-3">
                      <label className="form-label " htmlFor="formGridDOB">
                        Date Of Birth
                      </label>
                      <Field
                        name="dob"
                        type="text"
                        id="dob"
                        className="form-control"
                      />
                      <div id="dob-help" className="form-text">
                        ex. 01/01/1900
                      </div>
                      <ErrorMessage
                        name="dob"
                        component="div"
                        className="client-personal-input-error"
                      />
                    </div>
                  </div>
                  <div className="row mb-3">
                    <div className="col-3">
                      <label className="form-label " htmlFor="formGridemail">
                        Email
                      </label>
                      <Field
                        name="email"
                        type="email"
                        id="email"
                        className="form-control"
                      />
                      <ErrorMessage
                        name="email"
                        component="div"
                        className="client-personal-input-error"
                      />
                    </div>
                    <div className="col-3">
                      <label className="form-label " htmlFor="formGridphone">
                        Phone Number
                      </label>
                      <Field
                        name="phone"
                        type="phone"
                        id="phone"
                        className="form-control"
                      />
                      <div id="phone-help" className="form-text">
                        ex. 123-456-7891
                      </div>
                      <ErrorMessage
                        name="phone"
                        component="div"
                        className="client-personal-input-error"
                      />
                    </div>
                  </div>
                  <LocationsForm
                    onDataChange={onLocationFormChange}
                    defaultLocation={props.defaultLocation}
                  />
                  <div className="row mb-3 ms-1 " id="formGridCheckbox">
                    <div className="col-1 form-check">
                      <label>
                        <Field
                          onClick={() => setMarriedVis(!marriedVis)}
                          aria-controls="example-collapse-text"
                          aria-expanded={marriedVis}
                          className="form-check-input"
                          type="checkbox"
                          name="isMarried"
                          id="isMarried"
                        />
                        Is Married
                      </label>
                    </div>
                  </div>

                  <Collapse in={marriedVis}>
                    <div className="row mb-3">
                      <div className="col-4">
                        <label className="form-label " htmlFor="formGridState">
                          Spouse First Name
                        </label>
                        <Field
                          id="spouseFirstName"
                          name="spouseFirstName"
                          type="text"
                          className="form-control"
                        />
                        <ErrorMessage
                          name="spouseFirstName"
                          component="div"
                          className="client-personal-input-error"
                        />
                      </div>
                      <div className="col-4">
                        <label className="form-label " htmlFor="formGridState">
                          Spouse Last Name
                        </label>
                        <Field
                          id="spouseLastName"
                          name="spouseLastName"
                          type="text"
                          className="form-control"
                        />
                        <ErrorMessage
                          name="spouseLastName"
                          component="div"
                          className="client-personal-input-error"
                        />
                      </div>
                      <div className="col-1">
                        <label className="form-label " htmlFor="formGridState">
                          MI
                        </label>
                        <Field
                          id="spouseMi"
                          name="spouseMi"
                          type="text"
                          className="form-control"
                        />
                        <ErrorMessage
                          name="spouseMi"
                          component="div"
                          className="client-personal-input-error"
                        />
                      </div>
                      <div className="col-3">
                        <label className="form-label " htmlFor="formGridState">
                          Spouse Date of Birth
                        </label>
                        <Field
                          id="spouseDOB"
                          name="spouseDOB"
                          type="text"
                          className="form-control"
                        />
                        <div id="spouse-dob-help" className="form-text">
                          ex. 01/01/1900
                        </div>
                        <ErrorMessage
                          name="spouseDOB"
                          component="div"
                          className="client-personal-input-error"
                        />
                      </div>
                      <div className="row mt-3">
                        <div className="col-3">
                          <label
                            className="form-label "
                            htmlFor="formGridState"
                          >
                            Spouse Phone Number
                          </label>
                          <Field
                            id="spousePhone"
                            name="spousePhone"
                            type="text"
                            className="form-control"
                          />
                          <div id="spouse-phone-help" className="form-text">
                            ex. 123-456-7891
                          </div>
                          <ErrorMessage
                            name="spousePhone"
                            component="div"
                            className="client-personal-input-error"
                          />
                        </div>
                        <div className="col-3">
                          <label
                            className="form-label "
                            htmlFor="formGridState"
                          >
                            Spouse Email
                          </label>
                          <Field
                            id="spouseEmail"
                            name="spouseEmail"
                            type="text"
                            className="form-control"
                          />
                          <ErrorMessage
                            name="spouseEmail"
                            component="div"
                            className="client-personal-input-error"
                          />
                        </div>
                      </div>
                    </div>
                  </Collapse>
                  <h4>Do you have any kids or no kids?</h4>
                  <div className="row mb-3 ms-1 ">
                    <div className="col-1 form-check">
                      <label>
                        <Field
                          onClick={() => {
                            setKidsVis(!kidsVis);
                            values.hasKids = true;
                            values.hasNoKids = false;
                          }}
                          aria-controls="example-collapse-text"
                          aria-expanded={kidsVis}
                          className="form-check-input"
                          type="checkbox"
                          name="hasKids"
                          id="hasKids"
                        />
                        Yes
                      </label>
                    </div>
                    <div className=" col-1 form-check">
                      <label>
                        <Field
                          onClick={() => {
                            setKidsVis(false);
                            values.hasKids = false;
                          }}
                          aria-controls="example-collapse-text"
                          aria-expanded={kidsVis}
                          className="form-check-input"
                          type="checkbox"
                          name="hasNoKids"
                          id="hasNoKids"
                        />
                        No
                      </label>
                    </div>
                  </div>
                  <Collapse in={kidsVis}>
                    <div className="row mb-3">
                      <div className="col-3">
                        <label className="form-label " htmlFor="formGridState">
                          Number of Children
                        </label>
                        <Field
                          id="kidsNumber"
                          name="kidsNumber"
                          type="text"
                          className="form-control"
                        />
                        <ErrorMessage
                          name="kidsNumber"
                          component="div"
                          className="client-personal-input-error"
                        />
                      </div>
                      <div className="col-3">
                        <label className="form-label " htmlFor="formGridState">
                          Kids Ages
                        </label>
                        <Field
                          id="kidsAges"
                          name="kidsAges"
                          type="text"
                          className="form-control"
                        />
                        <div id="ages-help" className="form-text">
                          Separate each age by a comma
                        </div>
                        <ErrorMessage
                          name="kidsAges"
                          component="div"
                          className="client-personal-input-error"
                        />
                      </div>
                    </div>
                  </Collapse>
                  {!props.isInStepper && (
                    <div>
                      <button
                        type="submit"
                        className="btn btn-primary me-3 mt-3"
                      >
                        Submit
                      </button>
                    </div>
                  )}
                  {props.isInStepper && (
                    <div>
                      <button
                        type="submit"
                        onClick={props.onBack}
                        className="btn btn-secondary me-3 mt-3"
                        disabled={true}
                      >
                        {props.backLabel}
                      </button>
                      <button
                        type="submit"
                        className="btn btn-primary mt-3"
                        disabled={!locationData.lineOne}
                      >
                        {props.nextLabel}
                      </button>
                    </div>
                  )}
                </Form>
              )}
            </Formik>
            {/* This button is here to enable navigation without submission for development purposes only */}
            <button
              type="submit"
              onClick={props.onNext}
              className="btn btn-info mt-3"
            >
              {props.nextLabel}
            </button>
          </div>
        </div>
      </span>
    </div>
  );
}
ClientPersonal.propTypes = {
  giveClient: PropTypes.func,
  nextLabel: PropTypes.string,
  backLabel: PropTypes.string,
  onNext: PropTypes.func,
  onBack: PropTypes.func,
  clientId: PropTypes.number,
  defaultPersonalInfo: PropTypes.shape({
    firstName: PropTypes.string,
    lastName: PropTypes.string,
    middleInitial: PropTypes.string,
    dob: PropTypes.string,
    locationId: PropTypes.number,
    email: PropTypes.string,
    phone: PropTypes.string,
    isMarried: PropTypes.bool,
    spouseFirstName: PropTypes.string,
    spouseLastName: PropTypes.string,
    spouseMI: PropTypes.string,
    spouseDOB: PropTypes.string,
    spouseEmail: PropTypes.string,
    spousePhone: PropTypes.string,
    hasKids: PropTypes.bool,
    kidsNumber: PropTypes.number,
    kidsAges: PropTypes.string,
    hasNoKids: PropTypes.bool,
  }),
  defaultLocation: PropTypes.shape({
    id: PropTypes.number,
    locationTypeId: PropTypes.string,
    lineOne: PropTypes.string,
    lineTwo: PropTypes.string,
    city: PropTypes.string,
    zip: PropTypes.string,
    stateId: PropTypes.number,
    latitude: PropTypes.number,
    longitude: PropTypes.number,
  }),
  giveLocation: PropTypes.func,
  isInStepper: PropTypes.bool,
};
export default ClientPersonal;
