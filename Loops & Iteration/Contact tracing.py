patient1 = int(input())
patient1_contact1 = int(input())
patient1_contact2 = int(input())
patient2 = int(input())
patient2_contact1 = int(input())
patient2_contact2 = int(input())
patient3 = int(input())
patient3_contact1 = int(input())
patient3_contact2 = int(input())
query = int(input())

contact_tracing = {}
contact_tracing[patient1] = [patient1_contact1, patient1_contact2]
contact_tracing[patient2] = [patient2_contact1, patient2_contact2]
contact_tracing[patient3] = [patient3_contact1, patient3_contact2]

print("contacts  of", query)
print(contact_tracing.get(query, "No Data"))
if contact_tracing.get(query, "No Data") != "No Data":
    print("contacts of", contact_tracing.get(query)[0])
    print(contact_tracing.get(contact_tracing.get(query)[0], "No Data"))
    print("contacts of", contact_tracing.get(query)[1])
    print(contact_tracing.get(contact_tracing.get(query)[1], "No Data"))