package model.data.locations.mines {
public interface IMineInfo {


    function get occupantUserId():Number;

    function get occupationStartTime():Date;

    function get mineTypeId():int;

    function get mineKindId():int;

    function get timeFound():Date;

    function get timeToLiveDays():Number;

    function get resourceTotal():Number;

    function get maxArtifactIssueCost():Number;

    function get collectedResourceLimit():Number;

    function get collectionTimeDelayHours():Number;
}
}
