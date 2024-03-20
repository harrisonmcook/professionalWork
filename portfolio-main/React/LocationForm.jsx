import React, { useState, useEffect, useRef } from "react";
import { Formik, Form, Field, ErrorMessage } from "formik";
//import locationServices from "services/locationService";
import debug from "yellowbrick-debug";
import lookUpService from "services/lookUpService";
import locationSchema from "schemas/locationsSchema";
import LocationsAutoComplete from "./LocationsAutocomplete";
import toastr from "toastr";
//import { GoogleMap, LoadScript, Marker } from "@react-google-maps/api";
import { LoadScript } from "@react-google-maps/api";
import PropTypes from "prop-types";

const _logger = debug.extend("LocationsForm");
// const containerStyle = {
//   width: "500px",
//   height: "358px",
// };

function LocationsForm({ onDataChange, defaultLocation }) {
  const formikRef = useRef();

  const [autoComplete, setAutoComplete] = useState();

  const [lookups, setLookup] = useState({
    stateTypes: [],
    mappedStates: [],
    locationTypes: [],
    mappedLocations: [],
  });

  // const [latLong, setlatLng] = useState({
  //   lat: 0,
  //   lng: 0,
  // });

  useEffect(() => {
    lookUpService.lookUp(["States"]).then(lookUpSuccess).catch(lookUpError);
    lookUpService
      .lookUp(["LocationTypes"])
      .then(lookUpLocationSuccess)
      .catch(lookUpError);
  }, []);

  const onLoad = (auto) => {
    setAutoComplete(auto);
  };

  const lookUpSuccess = (response) => {
    setLookup((prevState) => {
      const state = { ...prevState };
      state.stateTypes = response.item.states;
      state.mappedStates = response.item.states.map(states);
      return state;
    });
  };
  const lookUpLocationSuccess = (response) => {
    _logger(response);
    setLookup((prevState) => {
      const ps = { ...prevState };
      ps.locationTypes = response.item.locationTypes;
      ps.mappedLocations = response.item.locationTypes.map(locationTypes);
      return ps;
    });
  };

  const lookUpError = (e) => {
    _logger(e);
    toastr.error("Lookup Could Not be Found!");
  };

  // const onSubmitClick = (values) => {
  //   // if (props.locationId > 0) {
  //   //   const id = values.id;
  //   //   locationServices
  //   //     .updateLocation(values, id)
  //   //     .then(updateSuccess)
  //   //     .catch(updateError);
  //   // } else {
  //   locationServices.add(values).then(locationSuccess).catch(locationError);
  // };

  // const locationSuccess = () => {
  //   toastr.success("Location Added!");
  // };

  // const locationError = (e) => {
  //   toastr.error("Location Has Not been Added!");
  //   _logger(e);
  // };

  // const updateSuccess = () => {
  //   toastr.success("Location Updated!");
  // };

  // const updateError = () => {
  //   toastr.error("Location Has Not been Updated!");
  // };

  const onPlaceChanged = () => {
    const location = autoComplete.getPlace();
    const lat = location?.geometry.location.lat();
    const long = location?.geometry.location.lng();
    const zipSearch = location?.address_components.filter((ele) =>
      ele.types.includes("postal_code")
    );
    const zip = zipSearch[0]?.short_name;

    const stateSearchNumber = location?.address_components.filter((ele) =>
      ele.types.includes("administrative_area_level_1")
    );
    const indx = lookups?.stateTypes?.findIndex(
      (state) => state.name === stateSearchNumber[0]?.long_name
    );
    const stateIdNumber = lookups?.stateTypes[indx]?.id;

    const citySearch = location?.address_components?.filter((ele) =>
      ele.types.includes("locality", "long_name")
    );
    const city = citySearch[0]?.long_name;
    const street = location?.name;

    formikRef.current.setFieldValue("lineOne", street);
    formikRef.current.setFieldValue("city", city);
    formikRef.current.setFieldValue("zip", zip);
    formikRef.current.setFieldValue("stateId", stateIdNumber);
    formikRef.current.setFieldValue("latitude", lat);
    formikRef.current.setFieldValue("longitude", long);
    // setlatLng({ lat: lat, lng: long });
    onDataChange({
      lineOne: street,
      city: city,
      zip: zip,
      stateId: stateIdNumber,
      latitude: lat,
      longitude: long,
    });
  };

  const states = (states) => {
    return <option value={states.id}>{states.name}</option>;
  };
  const locationTypes = (locationTypes) => {
    return <option value={locationTypes.id}>{locationTypes.name}</option>;
  };
  return (
    <>
      <Formik
        enableReinitialize={true}
        initialValues={defaultLocation}
        //onSubmit={onSubmitClick}
        validationSchema={locationSchema}
        innerRef={formikRef}
      >
        {({ values, setFieldValue }) => (
          <Form className="justify-content-md-center">
            <LoadScript
              googleMapsApiKey=REDACTED
              libraries={["places"]}
            >
              {/* {latLong.lng ? (
                  <div>
                    <GoogleMap
                      mapContainerStyle={containerStyle}
                      center={latLong}
                      zoom={15}
                    >
                      <Marker position={latLong} />
                    </GoogleMap>
                  </div>
                ) : (
                  <div></div>
                )} */}
              <div className="row">
                <LocationsAutoComplete
                  name="lineOne"
                  onLoad={onLoad}
                  onPlaceChanged={onPlaceChanged}
                  setFieldValue={setFieldValue}
                  onDataChange={onDataChange}
                  values={values}
                />
                <div className="mb-3 ">
                  <label className="form-label" htmlFor="formGridAddress2">
                    Address 2
                  </label>
                  <Field
                    name="lineTwo"
                    placeholder="Apartment, studio, or floor"
                    id="lineTwo"
                    className="form-control"
                    onChange={(e) => {
                      setFieldValue("lineTwo", e.currentTarget.value);
                      onDataChange({
                        ...values,
                        lineTwo: e.currentTarget.value,
                      });
                    }}
                  />
                </div>
              </div>
              <div className="mb-3 row">
                <div className="col-6">
                  <label className="form-label" htmlFor="formGridCity">
                    City
                  </label>
                  <Field
                    name="city"
                    id="formGridCity"
                    className="form-control"
                    onChange={(e) => {
                      setFieldValue("city", e.currentTarget.value);
                      onDataChange({
                        ...values,
                        city: e.currentTarget.value,
                      });
                    }}
                  />
                  <ErrorMessage
                    name="city"
                    component="div"
                    className="has-error"
                  />
                </div>
                <div className="col-6">
                  <label className="form-label" htmlFor="formGridState">
                    State
                  </label>
                  <Field
                    as="select"
                    name="stateId"
                    className="form-select"
                    id="formGridState"
                    onChange={(e) => {
                      setFieldValue("stateId", e.currentTarget.value);
                      onDataChange({
                        ...values,
                        stateId: e.currentTarget.value,
                      });
                    }}
                  >
                    <option value="">...Choose</option>
                    {lookups.mappedStates}
                  </Field>
                  <ErrorMessage
                    name="stateId"
                    component="div"
                    className="has-error"
                  />
                </div>
                <div className="col-6">
                  <label className="form-label" htmlFor="formGridZip">
                    Zip
                  </label>
                  <Field
                    name="zip"
                    id="formGridZip"
                    className="form-control"
                    onChange={(e) => {
                      setFieldValue("zip", e.currentTarget.value);
                      onDataChange({
                        ...values,
                        zip: e.currentTarget.value,
                      });
                    }}
                  />
                  <ErrorMessage
                    name="zip"
                    component="div"
                    className="has-error"
                  />
                </div>

                <div className="col-6">
                  <label
                    className="form-label"
                    htmlFor="formGridLocationTypeId"
                  >
                    Address Type
                  </label>
                  <Field
                    as="select"
                    name="locationTypeId"
                    className="form-select"
                    id="formGridLocationTypeId"
                    onChange={(e) => {
                      setFieldValue("locationTypeId", e.currentTarget.value);
                      onDataChange({
                        ...values,
                        locationTypeId: e.currentTarget.value,
                      });
                    }}
                  >
                    <option value="">...Choose</option>
                    {lookups.mappedLocations}
                  </Field>
                  <ErrorMessage
                    name="locationTypeId"
                    component="div"
                    className="has-error"
                  />
                </div>
              </div>
            </LoadScript>
          </Form>
        )}
      </Formik>
    </>
  );
}
LocationsForm.propTypes = {
  defaultLocation: PropTypes.shape({
    locationTypeId: PropTypes.string,
    lineOne: PropTypes.string,
    lineTwo: PropTypes.string,
    city: PropTypes.string,
    zip: PropTypes.string,
    stateId: PropTypes.number,
    latitude: PropTypes.number,
    longitude: PropTypes.number,
  }),
  onDataChange: PropTypes.func,
};
export default LocationsForm;
//
