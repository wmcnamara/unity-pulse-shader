using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraMovement : MonoBehaviour
{
    [SerializeField] private float MovementSpeed = 5.0f;

    void Update()
    {
        float rightMovement = Input.GetAxis("Horizontal");
        float forwardMovement = Input.GetAxis("Vertical");
        float upMovement = Input.GetAxis("UpDown");

        Vector3 translation = new Vector3(rightMovement, upMovement, forwardMovement);

        translation.Normalize();
        translation = translation * Time.deltaTime * MovementSpeed;

        transform.Translate(translation, Space.Self);
    }
}
